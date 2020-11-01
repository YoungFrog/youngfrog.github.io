---
layout: post
title: "Google : OAuth2 vs Service accounts vs API Key"
categories: informatique
summary: "L'état de ma compréhension, incomplète, de l'identification (authentification) pour utiliser les API Google"
---
## Pourquoi je m'intéresse à l'identification

Depuis quelques jours je m'intéresse à un problème simple : 
récupérer des infos depuis une Google Sheet (publique) via javascript.
TL;DR : je n'y arrive pas.

Pour faire simple, c'était possible mais ça ne l'est plus trop.

### Publier sur le Web
Une solution était de "publier sur le Web", ce qui peut se faire en csv, la ressource visée (via le menu Fichier de l'interface Sheets).
Malheureusement l'URL n'est pas (plus) utilisable depuis javascript à défaut de CORS approprié. Il semblerait que ce soit un changement voulu par Google :

	Hi,
	I've extensively reported this issue to Google and this was their final answer :

		After verifying too the logs, there were changes on how the files are downloaded from the published link, which were done to help protect the published links as a part of Google Cloud's ongoing work to keep its products secure.

		As the published links were not designed to be used programmatically, it is recommend to use the Drive API call files.export [1] instead (requires a project, subject to quotas) to download the file:
		[1] https://developers.google.com/drive/api/v3/reference/files/export

		As an alternative too from the update, I suggest using the search term below to help check other Google Sheets link format that can be tried or tested, to help export them as a CSV file without redirection:

		download link for google spreadsheets CSV export with multiple sheets

(Source: <https://support.google.com/docs/thread/56845119>)

### Publier sur le Web en JSON
D'après <https://www.freecodecamp.org/news/cjn-google-sheets-as-json-endpoint/>, c'était même possible en Json. Même procédure. Même impossibilité.

### Via l'API sans identification

Une autre solution eut été d'utiliser l'API officielle. 
D'après <https://developers.google.com/drive/api/v3/reference/files/export> on doit pouvoir faire des appels non-authentifié à l'API mais j'obtiens toujours une erreur.

### Via l'API avec identification

Pour s'identifier, il faut un secret partagé, et ce n'est pas compatible avec une application côté client.

### Conclusion
Le problème reste non-résolu. Malgré tout, cela m'a incité à comprendre mieux l'identification "sauce Google".

## Quelques détails sur l'identification (authentification)

J'identifie dans un premier temps trois mécanismes d'identification : 

- OAuth
- API Key
- OAuth pour les comptes de service

(voir <https://console.developers.google.com/apis/credentials/>, qui propose un menu "Aidez-moi à choisir")

<!-- Ce menu signale que si on veut une application Javascript qui utilise (des données publiques)(iirc), il n'y a pas de solution. -->

Le choix dépendra du type de données auxquelles il faut pouvoir accéder, respectivement :

- Données de l'utilisateur utilisant l'application (OAuth)
- Données de l'utilisateur développant l'application (API Key)
- Données non-spécifiques à un utilisateur, mais spécifiques à l'application (compte de service)

### OAuth

Le principe est que l'utilisateur de l'application s'identifie en tant qu'utilisateur de Google, afin que l'application puisse utiliser ses données Google.
Cela ne correspond pas à mon cas d'utilisation puisque je ne veux pas utiliser les données de l'utilisateur courant.

Source: <https://developers.google.com/sheets/api/quickstart/python>

### API Key

Je comprends qu'une API key permet d'accéder aux données du compte ayant servi à générer la clef en question. 
<!-- Je ne suis pas sûr, je n'ai pas testé récemment. -->

Ceci peut correspondre à mon cas d'utilisation même si en réalité les données sont publiques, mais le fait que cette clef est liée à mon compte n'est probablement pas idéal.

#### Mais je comprends pas tout

On doit pouvoir tester via [la documentation de l'API](https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/get)

La clef API doit être gardée en sécurité, i.e. pas utilisée côté client : <https://support.google.com/googleapi/answer/6310037>
C'est un peu louche que sur <https://developers.google.com/sheets/api/quickstart/js> on propose de mettre la clef API dans le code JS... mais on y met aussi un Client ID. Est-ce en réalité du OAuth ?!

### Compte de service

(source: <https://github.com/googleapis/google-api-python-client/blob/master/docs/oauth-server.md>)

J'ai dû créer un compte de service, créer une clé dessus, ce qui me télécharge un fichier `.json`.

J'ai ensuite créé ce programme Python qui me crée un fichier `resultat.json` :

```python
	from googleapiclient.discovery import build
	from google.oauth2 import service_account
	import json

	SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']
	# obviously adjust this to your needs
	SERVICE_ACCOUNT_FILE = 'credentials.json'

	# The Sheet ID where the data is stored.
	SHEET_ID = '1x9ZtVIWmPetmmIYNCs6yZoByBH4hCa9w5Z7zOM2vcTM'
	RANGE_NAME = 'Feuille 1!A1:B'


	def main():
		"""Shows basic usage of the Sheets API.
		Prints values from a sample spreadsheet.
		"""
		creds = service_account.Credentials.from_service_account_file(
			SERVICE_ACCOUNT_FILE, scopes=SCOPES)
		service = build('sheets', 'v4', credentials=creds)

		# Call the Sheets API
		sheet = service.spreadsheets()
		result = sheet.values().get(spreadsheetId=SHEET_ID,
									range=RANGE_NAME).execute()
		values = result.get('values', [])

		if not values:
			print('No data found.')
		else:
			with open("resultat.json", 'w') as outfile:
				json.dump(dict(values), outfile)

	if __name__ == '__main__':
		main()
```
