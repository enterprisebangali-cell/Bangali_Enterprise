# Bangali Enterprise Deployment Guide

This guide details how to deploy the Bangali Enterprise application to a production environment.

## Prerequisites

- **Domain Name**: You mentioned you already have one.
- **Hosting**: A standard hosting plan (cPanel, Hostinger, GoDaddy, etc.) or a VPS (Ubuntu/Nginx).
- **Supabase Project**: You must have your Supabase project URL and Anon Key ready.

## 1. Environment Configuration

Ensure your `.env` file in the project root is correct before building. It should look like this:

```env
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

> [!IMPORTANT]
> These variables are **baked into the code** during the build process. If you change them, you must **rebuild** the application.

## 2. Build the Application

Run the following command in your terminal to generate the production files:

```bash
npm run build
```

This will create a `dist` folder in your project directory containing:
- `index.html`
- `assets/` folder (CSS, JS, Images)
- `.htaccess` (Server configuration)

## 3. Upload to Hosting (cPanel / Shared Hosting)

1.  **Log in** to your hosting control panel (e.g., cPanel).
2.  Open **File Manager** and navigate to `public_html` (or the specific folder for your domain).
3.  **Upload** the contents of the `dist` folder.
    - **Do NOT** upload the `dist` folder itself, upload what is *inside* it.
    - Your `public_html` should directly contain `index.html` and the `assets` folder.
4.  **Verify**: Visit your domain in the browser.

### Troubleshooting (404 on Refresh)

If you visit a page like `yourdomain.com/dashboard` and refresh, and get a 404 error:
- Ensure the `.htaccess` file was uploaded. This file is hidden on some systems.
- It is located in the `public` folder of the source code and copied to `dist` during build.

## 4. VPS / Nginx Deployment (Advanced)

If you are using a VPS with Nginx, your server block should include this `try_files` directive to handle routing:

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /var/www/bangali-enterprise;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```
