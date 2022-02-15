const { chromium } = require('playwright');
const browser = await chromium.launch()
const page = await browser.newPage()
const navigationPromise = page.waitForNavigation()

await page.goto('https://fzs.roskazna.ru/')

await page.setViewportSize({ width: 1280, height: 881 })

await page.waitForSelector('body')
await page.click('body')

await page.waitForSelector('#btn-send-request')
await page.click('#btn-send-request')

await page.waitForSelector('.scroll-hide > .modal > .ui-dialog')
await page.click('.scroll-hide > .modal > .ui-dialog')

await page.waitForSelector('#continueButton')
await page.click('#continueButton')

await navigationPromise

await page.waitForSelector('body')
await page.click('body')

await page.waitForSelector('#select2-RegionCode-container')
await page.click('#select2-RegionCode-container')

await page.waitForSelector('.request-data-table-app-type > tbody > tr > td > .ui-radiobutton')
await page.click('.request-data-table-app-type > tbody > tr > td > .ui-radiobutton')

await page.waitForSelector('tbody > tr > td > .ui-radiobutton > label:nth-child(2)')
await page.click('tbody > tr > td > .ui-radiobutton > label:nth-child(2)')

await page.waitForSelector('#r-ogrn')
await page.click('#r-ogrn')

await page.waitForSelector('#r-ogrn')
await page.click('#r-ogrn')

await page.waitForSelector('#r-ogrn')
await page.click('#r-ogrn')

await page.waitForSelector('#createRequestForm > section > .section-footer > .section-footer-right > .btn-b')
await page.click('#createRequestForm > section > .section-footer > .section-footer-right > .btn-b')

await navigationPromise

await browser.close()