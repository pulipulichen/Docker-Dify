const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 21080;
const HOST = `http://192.168.100.202:${PORT}/`

// HTML 檔案所在的資料夾
const HTML_FOLDER = path.join(__dirname, 'html');

// 產生 HTML 頁面
function generateHTML() {
    let articles = '';

    // 遍歷 HTML 資料夾，生成每個檔案的 <article>
    fs.readdirSync(HTML_FOLDER)
        .filter(file => path.extname(file) === '.html') // 篩選 HTML 檔案
        .forEach(file => {
            const filePath = path.join(HTML_FOLDER, file);
            const stats = fs.statSync(filePath);

            articles += `
            <article>
                <h2><a href="${HOST}${file}" target="_blank">${file}</a></h2>
                <p>Last modified: ${stats.mtime}</p>
            </article>
            `;
        });

    // 包裝成完整的 HTML
    return `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HTML File List</title>
        <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; padding: 20px; }
            article { border: 1px solid #ddd; padding: 10px; margin-bottom: 15px; }
            h2 { margin: 0 0 10px; }
            a { text-decoration: none; color: #007BFF; }
            a:hover { text-decoration: underline; }
            p { color: #555; font-size: 0.9em; }
        </style>
    </head>
    <body>
        <h1>HTML File List</h1>
        ${articles}
    </body>
    </html>
    `;
}

// 提供動態生成的 HTML 頁面
app.get('/', (req, res) => {
    const html = generateHTML();
    res.set('Content-Type', 'text/html');
    res.send(html);
});

// 提供 HTML 資料夾的靜態檔案
app.use(express.static(HTML_FOLDER));

// 啟動伺服器
app.listen(PORT, () => {
    console.log(`Server is running at ${HOST}`);
});
