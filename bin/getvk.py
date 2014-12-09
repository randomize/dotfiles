#!/usr/bin/python2
# -*- coding: utf-8 -*-
#------------------------------------------------------------
# getvk.py URL wrapper for vk / vkontakte videos
#
# based in:
# pelisalacarta - XBMC Plugin
# Conector para VK Server
# http://blog.tvalacarta.info/plugin-xbmc/pelisalacarta/
#
# Modify: 2011-09-12, by Ivo Brhel
# Modify: 2012-05-03, by vdo < vdo.pure at gmail.com >
# Modify: 2014-12-03, by Mihailenco Eugene < mihailencoe at gmail.com >
#
#------------------------------------------------------------

import urlparse,urllib2,urllib,re
import os,sys



def geturl(url):
    req = urllib2.Request(url)
    req.add_header('User-Agent', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3')
    response = urllib2.urlopen(req)
    link=response.read()
    return link



# Returns an array of possible video url's from the page_url
def get_video_urls( page_url , best = False, premium = False , user="" , password="", video_password="" ):
    # print("[vk.py] get_video_urls(page_url='%s')" % page_url)

    # Lee la pagina y extrae el ID del video
    #data = scrapertools.cache_page(page_url.replace("amp;",""))
    data = geturl(page_url.replace("amp;",""))
    videourl = ""
    regexp =re.compile(r'vkid=([^\&]+)\&')
    match = regexp.search(data)
    vkid = ""
    if match is not None:
        vkid = match.group(1)
    else:
        print("no vkid")

    # Extrae los parametros del video y acade las calidades a la lista
    patron  = "var video_host = '([^']+)'.*?"
    patron += "var video_uid = '([^']+)'.*?"
    patron += "var video_vtag = '([^']+)'.*?"
    patron += "var video_no_flv = ([^;]+);.*?"
    patron += "var video_max_hd = '([^']+)'"
    matches = re.compile(patron,re.DOTALL).findall(data)
    #scrapertools.printMatches(matches)

    video_urls = []

    if len(matches)>0:
        for match in matches:
            if match[3].strip() == "0" and match[1] != "0":
                tipo = "flv"
                if "http://" in match[0]:
                    videourl = "%s/u%s/video/%s.%s" % (match[0],match[1],match[2],tipo)
                else:
                    videourl = "http://%s/u%s/video/%s.%s" % (match[0],match[1],match[2],tipo)

                # Lo acade a la lista
                video_urls.append( ["FLV [vk]",videourl])

            elif match[1]== "0" and vkid != "":     #http://447.gt3.vkadre.ru/assets/videos/2638f17ddd39-75081019.vk.flv
                tipo = "flv"
                if "http://" in match[0]:
                    videourl = "%s/assets/videos/%s%s.vk.%s" % (match[0],match[2],vkid,tipo)
                else:
                    videourl = "http://%s/assets/videos/%s%s.vk.%s" % (match[0],match[2],vkid,tipo)

                # Lo acade a la lista
                video_urls.append( ["FLV [vk]",videourl])

            else:                                   #http://cs12385.vkontakte.ru/u88260894/video/d09802a95b.360.mp4
                #quality = config.get_setting("quality_flv")
                quality = "1"
                #Si la calidad elegida en el setting es HD se reproducira a 480 o 720, caso contrario solo 360, este control es por la xbox
                if match[4]=="0":
                    video_urls.append( ["240p [vk]",get_mp4_video_link(match[0],match[1],match[2],"240.mp4")])
                elif match[4]=="1":
                    video_urls.append( ["240p [vk]",get_mp4_video_link(match[0],match[1],match[2],"240.mp4")])
                    video_urls.append( ["360p [vk]",get_mp4_video_link(match[0],match[1],match[2],"360.mp4")])
                elif match[4]=="2":
                    video_urls.append( ["240p [vk]",get_mp4_video_link(match[0],match[1],match[2],"240.mp4")])
                    video_urls.append( ["360p [vk]",get_mp4_video_link(match[0],match[1],match[2],"360.mp4")])
                    video_urls.append( ["480p [vk]",get_mp4_video_link(match[0],match[1],match[2],"480.mp4")])
                elif match[4]=="3":
                    video_urls.append( ["240p [vk]",get_mp4_video_link(match[0],match[1],match[2],"240.mp4")])
                    video_urls.append( ["360p [vk]",get_mp4_video_link(match[0],match[1],match[2],"360.mp4")])
                    video_urls.append( ["480p [vk]",get_mp4_video_link(match[0],match[1],match[2],"480.mp4")])
                    video_urls.append( ["720p [vk]",get_mp4_video_link(match[0],match[1],match[2],"720.mp4")])
                else:
                    video_urls.append( ["240p [vk]",get_mp4_video_link(match[0],match[1],match[2],"240.mp4")])
                    video_urls.append( ["360p [vk]",get_mp4_video_link(match[0],match[1],match[2],"360.mp4")])

    if best:
        print("%s" % video_urls[-1][1])
    else:
        for video_url in video_urls:
            print("%s - %s" % (video_url[0],video_url[1]))

    #return video_urls
    result = video_urls[len(video_urls)-1]
    return result[1]


def get_mp4_video_link(match0,match1,match2,tipo):
    if match0.endswith("/"):
        videourl = "%su%s/videos/%s.%s" % (match0,match1,match2,tipo)
    else:
        videourl = "%s/u%s/videos/%s.%s" % (match0,match1,match2,tipo)
    return videourl

def print_usage():
        print('''
usage: getvk.py <url>  - list all avaliable videos
       getvt.py --best <url> - output only best quality video
        ''')


if __name__ == '__main__':

    arg_count = len(sys.argv)

    if arg_count == 2:
        get_video_urls(sys.argv[1])

    elif arg_count == 3:
        if sys.argv[1] == "--best":
            get_video_urls(sys.argv[2], best=True)
        elif sys.argv[2] == "--best":
            get_video_urls(sys.argv[1], best=True)
        else:
            print_usage()
    else:
        print_usage()


