const express = require('express');
const axios = require('axios');
const xlsx = require('xlsx');
const app = express();
const port = 31080;

// GET 接收 Excel URL
app.get('/', async (req, res) => {
    const url = req.query.url;

    if (!url) {
        return res.status(400).send('請提供有效的Excel檔案網址');
    }

    try {
        // 下載 Excel 檔案
        const response = await axios.get(url, { responseType: 'arraybuffer' });
        const data = response.data;

        // 使用 xlsx 解析 Excel 資料
        const workbook = xlsx.read(data, { type: 'buffer' });
        const sheetName = workbook.SheetNames[0]; // 讀取第一個工作表
        const sheet = workbook.Sheets[sheetName];
        const jsonData = xlsx.utils.sheet_to_json(sheet, { defval: "" });

        // 獲取標題列（第一列）
        const headers = Object.keys(jsonData[0] || {});

        // 轉換資料格式
        const result = jsonData.map(row => {
            return headers
                .filter(header => row[header].trim() !== "") // 過濾掉空值欄位
                .map(header => `"${header}":"${row[header]}"`)
                .join(';');
        }).join('\n####\n');

        // 回傳結果
        res.send(result);

    } catch (error) {
        // console.error('處理Excel檔案時發生錯誤:', error);
        res.status(500).send('無法處理Excel檔案，請確認網址是否有效');
    }
});

// 啟動伺服器
app.listen(port, () => {
    console.log(`伺服器已啟動，網址：http://localhost:${port}`);
});
