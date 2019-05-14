# encoding=utf-8
import requests
import codecs
from bs4 import BeautifulSoup

# 豆瓣电影top250网址
URL = 'https://movie.douban.com/top250/'

def download_page(url):
    # 下载页面HTML文件
    # 模拟浏览器U-A机制应对反爬机制
    return requests.get(url,headers={\
    'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36'})\
    .content

def parse_html(html):
    bs = BeautifulSoup(html)
    movie_list_soup = bs.find('ol',attrs={'class':'grid_view'})
    # 电影名称list
    movie_name_list = []

    for movie_li in movie_list_soup.find_all('li'):
        detail = movie_li.find('div',attrs={'class':'hd'})
        movie_name = detail.find('span',attrs={'class':'title'}).getText()
        movie_name_list.append(movie_name)
    
    Have_next_page = bs.find('span',attrs={'class':'next'}).find('a')
    if Have_next_page:
        return movie_name_list, URL + Have_next_page['href']
    return movie_name_list, None

def main():
    url = URL
    with codecs.open('movies','wb',encoding='utf-8') as fp:
        while url:
            html = download_page(url)
            movies, url = parse_html(html)
            fp.write(u'{movies}\n'.format(movies='\n'.join(movies)))

# 运行程序
main()
