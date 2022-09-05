const fs = require('fs');
const path = require('path');
const axios = require('axios');
const cheerio = require('cheerio')
const ejs = require('ejs');

/**
 * 
 * @param {*} seconds 秒
 */
const sleep = (seconds) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve()
    }, seconds * 1000)
  })
}

async function handlePage(page) {
  const start = page * 25;
  const url = `https://www.douban.com/doulist/147208859/?start=${start}&sort=seq&playable=0&sub_type=`;
  const response = await axios.get(url);
  const html = response.data;
  const $ = cheerio.load(html);
  const results = []

  const lists = $('.article .doulist-item');
  if(lists.length) {
    lists.map((index, item) => {
      item = $(item);
      /** 电影名称 */
      let title = '';
      /** 豆瓣链接 */
      let link = '';
      /** 电影封面 */
      let image = '';
      /** 电影评分 */
      let rating = ''
  
      const titleLinkEle = item.find('.doulist-subject>.title>a');
      if(titleLinkEle) {
        link = titleLinkEle.prop('href');
        title = titleLinkEle.text().trim();
      }
  
      const imageEle = item.find('.doulist-subject>.post>a>img');
      if(imageEle) {
        image = imageEle.prop('src');
      }
  
      const ratingNumsEle = item.find('.doulist-subject>.rating>.rating_nums')
      if(ratingNumsEle) {
        rating = ratingNumsEle.text().trim();
      }
  
      const comment = item.find('.ft .comment').text()
  
      results.push({
        title,
        link,
        image,
        rating,
        comment
      })
    })
  }
  console.log(`第 ${page + 1} 页完成`);
  return results;
}

async function handleMultiPage() {
  let results = [];
  let i = 0;
  let hasMore = true;
  while(hasMore) {
    const pageResults = await handlePage(i);
    hasMore = !!pageResults.length
    results = results.concat(pageResults);
    i++;
    await sleep(2);
  }
  console.log(`所有页面爬取完毕, 共 ${results.length} 条数据`);
  return results;
}

async function generateHtml(year, name) {
  const tmpStr = fs.readFileSync('./index.tpl', { encoding: 'utf8'}).toString();
  let movies = fs.readFileSync(`./douban-movie-calendar-${year}.json`, { encoding: 'utf8'})
  movies = JSON.parse(movies);
  const html = ejs.render(tmpStr, {
    movies,
    title: `${year} 豆瓣电影日历`,
    year
  });

  fs.writeFileSync(`./${name}.html`, html);
}

async function main() {
  // 收集数据
  // const results = await handleMultiPage();
  // fs.writeFileSync(path.join(__dirname, 'douban-movie-calendar-2022.json'), JSON.stringify(results, null, 2))
  // console.log('已写入文件，结束!');

  // 渲染页面
  await generateHtml(2017, '2017')
  await generateHtml(2018, '2018')
  await generateHtml(2019, '2019')
  await generateHtml(2020, '2020')
  await generateHtml(2021, '2021')
  await generateHtml(2022, 'index')
  console.log('页面已生成');
}

main();




