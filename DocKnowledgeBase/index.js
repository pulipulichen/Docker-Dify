const express = require('express');
const fs = require('fs');
const path = require('path');
const RSS = require('rss');

const app = express();
const PORT = 21080;
const HOST = `http://192.168.100.195:21080/`

// HTML 檔案所在的資料夾
const HTML_FOLDER = path.join(__dirname, 'html');

// RSS 資訊
const feed = new RSS({
    title: 'HTML Files RSS Feed',
    description: 'RSS feed generated from HTML files',
    feed_url: `${HOST}rss`,
    site_url: HOST,
    language: 'zh-tw',
    pubDate: new Date(),
});

// 遍歷 HTML 資料夾，將每個檔案加入 RSS
fs.readdir(HTML_FOLDER, (err, files) => {
    if (err) {
        console.error('Error reading HTML folder:', err);
        return;
    }

    files.filter(file => path.extname(file) === '.html').forEach(file => {
        const filePath = path.join(HTML_FOLDER, file);
        const stats = fs.statSync(filePath);

        feed.item({
            title: file,
            description: `HTML file: ${file}`,
            url: `${HOST}${file}`, // 生成對應的 URL
            date: stats.mtime, // 檔案的最後修改時間
        });
    });
});

// 提供 RSS feed
app.get('/rss', (req, res) => {
    res.set('Content-Type', 'application/rss+xml');
    res.send(feed.xml());
});

// 提供 HTML 資料夾的靜態檔案
app.use(express.static(HTML_FOLDER));

// 啟動伺服器
app.listen(PORT, () => {
    console.log(`Server is running at ${HOST}`);
    console.log(`RSS feed available at ${HOST}rss`);
});
