# TOC

Using: https://github.com/allejo/jekyll-toc

Installation : ran

    wget -O_includes/toc.html https://raw.githubusercontent.com/allejo/jekyll-toc/master/_includes/toc.html

and included `{% include toc.html html=content %}` in the template `post.html`

# Images
There's a plugin. I'm not using it :
https://nhoizey.github.io/jekyll-postfiles/ (works on github)

I just went for a /pics/ directory.

I also took inspiration from a blog post :
https://pnmcartodesign.wordpress.com/2018/10/01/how-to-create-a-featured-image-template-for-a-jekyll-blog-site/

(add a new "include" used in the post.html template)

# Summary
J'ai ajouté un élément de configuration tout bête summary: et indiqué à mon layout post.html de l'utiliser s'il est là. Le code css pour blockquote était déjà fait.


# Opengraph

how does FB parse your URL
https://developers.facebook.com/tools/debug/

adding a few meta tags. here's an opengraph documentation :
https://developers.facebook.com/docs/sharing/webmasters#markup

And the og doc for the full list of types :
https://ogp.me/#types
