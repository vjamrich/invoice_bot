# VAT Appeal Bot
An internal web app designed for the Tax & Legal Services team within PwC Czech Republic. This app fully automates the process of interpreting tax documents for clients.

## Usage
[🔗 VAT Appeal Bot web app](https://vat-appeal-bot.web.app/)

To use this app, you need to upload a received notice in a pdf format (please ensure the notice is not password protected).

![](/assets/upload_screen.png)

The app will analyse the notice and extract the relevant information, such as the company name, TIN, invoice numbers, and dates.

![](/assets/overview_screen.png)

Based on the content of the notice, the app will generate an email response for your client, following the best practices of PwC Tax & Legal services. The email will include a greeting, a summary of the invoices of concern, and a closing remarks.
You can review and edit the generated email before copying and sending it to your client. Please ensure that the generated text is accurate and appropriate for your client’s situation.

![](/assets/generate_screen.png)

## How it works
The app is built on top of Flutter framework using Dart language. The document parsing is done using RegEx, while Firebase and Google Cloud is used as backend providing access to NoSQL database, hosting, and analytics.
