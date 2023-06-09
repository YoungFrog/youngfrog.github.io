---
layout: post
title: "OAuth 2 with PKCE in the browser"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

I found these libraries :

- oauth2-pkce <https://www.npmjs.com/package/oauth2-pkce> (said to be a rewrite of <https://www.npmjs.com/package/oauth2-auth-code-pkce>)

- oauth2-client <https://www.npmjs.com/package/@badgateway/oauth2-client>

- oidc-client-ts <https://www.npmjs.com/package/oidc-client-ts>

Some more can be found at https://oauth.net/code/javascript/ and https://openid.net/developers/certified/ (OpenID Connect, or oidc for short, is actually a layer atop OAuth2).

These are generic libraries for OAuth2-conforming identity providers (Gitlab, Twitter, etc.).

For some specific APIs and identity providers, there are specific clients with specific documentation such as:
- Google : <https://github.com/google/google-api-javascript-client/tree/master/docs>
- Microsoft : <https://github.com/AzureAD/microsoft-authentication-library-for-js>

If looking for an thorough explanations of the OAuth2 with PKCE flow from scratch, including an implementation, <https://www.valentinog.com/blog/oauth2/> seems a good read.

## oauth2-pkce

This one is the less popular of the three. It supports only PKCE (which is the right thing, for SPAs).

While they say "it was written for SPAs", it seems that the onus of redirecting the user to the login page is on you, still, which means either leaving the SPA, or going to a popup window.

I had an error from Gitlab, because Gitlab requires a client_secret when fetching the token (not actually secret, but still required). This can be done using the `oneTimeParams` argument to `getTokens` :

Excerpt from the "callback" page :

    if (new URL(document.location).searchParams.has('code')) {
        await oauthClient.receiveCode();
        const tokens = oauthClient.getTokens({ client_secret: config.clientSecret })
        console.log(tokens);
    }

## oauth2-client

This one is more popular, supports more OAuth2 flows.

I had the following error :

    TypeError: 'fetch' called on an object that does not implement interface Window
    
but this was fixed by setting `fetch: fetch.bind(window)` in the OAuth2 client configuration.

## oidc-client-ts

This one is actually a full featured OpenId Connect (oidc) client. 
oidc is a layer atop  oauth2, and is vastly supported.

The main gripe I have with this one is that I found it very difficult to understand the documentation. Possibly my fault, of course. 
The example project (`Parcel`) is plenty interesting though. It offers various ways of signing in, including redirection or popup, which is neat.

On the other hand it's a bigger beast to tame if you want to look at the code.

I had one issue : because I sometimes use `npx serve`, which uses `cleanUrls` by default (strips `.html` extensions from the url with a redirection), I was missing a piece of state from my redirections (for some reason the query string was stripped too).
