# -*- coding: utf-8 -*-
"""
Created on Sun Sep  9 08:19:35 2018

@author: admin
"""

from aiohttp import web
import json
import web_crawler_scraper as cs

username_2ID = [] 
ID_2past_interest = []

routes = web.RouteTableDef()
def check_name(username):
  for x in username_2ID:
    if x == username:
      return True
  return False

def retrieve_name_ID(username):
  for x in range(len(username_2ID)):
    if username_2ID[x] == username:
      return x
  return -1# should raise error in future

@routes.get('/{username}')
async def login(request):
  #async def login(username, password):
  #print("######")
  username = request.match_info['username']
  if not check_name(username):
    username_2ID.append(username)
    print("User "+str(username)+" has signed up successfully.")
    #username_2ID[assigned_ID] = username
    ID_2past_interest.append(["internet monster","",""])
  print("User "+str(username)+" has logged in.")
  past_interest = {"past_interst_1": ID_2past_interest[retrieve_name_ID(username)][-1], "past_interst_2": ID_2past_interest[retrieve_name_ID(username)][-2], "past_interst_3": ID_2past_interest[retrieve_name_ID(username)][-3]}
  return web.json_response(past_interest)

#@routes.get('/query')
@routes.get('/{username}/{keyword}')
#app.router.add_resource(r'/{user}/info', name='user-info')
async def query(request):
  username = request.match_info['username']
  keyword = request.match_info['keyword']
  ID_2past_interest[retrieve_name_ID(username)].append(keyword)
  _summary_list = cs.keywords_search(keyword)
  res = json.dumps(_summary_list)
  return web.json_response(res)

app = web.Application()
#app.router.add_get('/login', login)
app.router.add_routes(routes)

web.run_app(app)




  
  
  
