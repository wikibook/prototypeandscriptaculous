# python scripts to read output files from Fiddler or LiveHTTPHeaders
# and generate CSV files suitable for plotting in a spreadsheet
#
# (c) Dave Crane, May 2006

import sys
import string
import time
import re

# main parsing class
class TrafficParser:

  # constructor opens file and parses it
  def __init__(self,infile):
    self.traffic=[]
    self.request={}
    self.response={}
    self.threshold=100000  #ignore files above this size (e.g. big digital camera images)
    self.file=open(infile,"r")
    try:
      while(1):
        self.parse()
    except StopIteration:
      self.file.close()

  # parse the next line, with some options triggering read of several lines
  def parse(self):
    f=self.file
    line=f.next()
    if line[0:3]=="GET":
      self.parseRequest(line)
    elif line[0:4]=="POST":
      self.parseRequest(line)
    elif line[0:4]=="HTTP":
      self.parseResponse(line)
    elif self.isDelimiter(line):
      # fiddler puts an empty line between response and delimiter, so
      # will hit this line of code
      self.storeCurrent()

  #test whether a line is a delimiter between request-response pairs
  #both fiddler and livehttp use a sequence of minus signs
  def isDelimiter(self,line):
    return (line[0:4]=="----")

  # store current request and response in the list self.traffic      
  def storeCurrent(self):
    if len(self.response)>0:
      self.traffic.append({"request":self.request,"response":self.response})

  #parse a request block
  def parseRequest(self,line):
    self.request={}
    self.response={}
    [self.request['verb'],self.request['url'],self.request['protocol']]=line.split(" ",2)
    self.parseHeaders(line,self.request)

  #parse a response block
  def parseResponse(self,line):
    self.response={}
    [self.response['protocol'],self.response['statusCode'],self.response['statusMsg']]=line.split(" ",2)
    self.parseHeaders(line,self.response)

  #parse a header block for request or response
  def parseHeaders(self,line,owner):
    owner['headers']={}
    bytecount=0
    while len(line.strip())>1:
      line=self.file.next()
      header=line.split(":",1)
      if len(header)==2:
        owner['headers'][header[0].strip()]=header[1].strip()
        bytecount+=len(line)
      elif self.isDelimiter(line):
        #livehttp files have no gap between response headers and
        #the delimiter, so catch them now
        break
    owner['headers']['Header-Size']=str(bytecount)
    if self.isDelimiter(line):
      #caught by livehttp format
      self.storeCurrent()


  def report(self,urlRegex=0):
    print "url,response status,mime type,timestamp,request headers,request content,response headers,response content" 
    mimeHistogram={}
    cumReqHdrLen=0
    cumRespHdrLen=0
    cumReqConLen=0
    cumRespConLen=0
    currUrl=None
    currStatus=None
    currMimetype=None
    currTimfl=0.0
    regex=0
    if urlRegex:
      regex=re.compile(urlRegex)
    for t in self.traffic:
      req=t['request']
      resp=t['response']
      url=req['url']
      status=resp['statusCode']
      mimetype="--"
      if resp['headers'].has_key('Content-Type'):
        mimetype=resp['headers']['Content-Type']
      timstr=resp['headers']['Date']
      timtup=time.strptime(timstr,'%a, %d %b %Y %H:%M:%S %Z')
      timfl=time.mktime(timtup)
      reqConLen="0"
      respConLen="0"
      reqHdrLen=req['headers']['Header-Size']
      if req['headers'].has_key("Content-Length"):
        reqConLen=req['headers']['Content-Length']
      respHdrLen=resp['headers']['Header-Size']
      if resp['headers'].has_key("Content-Length"):
        respConLen=resp['headers']['Content-Length']
      if regex:
        if regex.search(url): 
          if currUrl!=None:
            print string.join([currUrl,currStatus,currMimetype,str(currTimfl),str(cumReqHdrLen),str(cumReqConLen),str(cumRespHdrLen),str(cumRespConLen)],",")   
          currUrl=url
          currStatus=status
          currMimetype=mimetype
          currTimfl=timfl
          cumReqHdrLen=0
          cumRespHdrLen=0
          cumReqConLen=0
          cumRespConLen=0
        cumReqHdrLen+=int(reqHdrLen)
        cumRespHdrLen+=int(respHdrLen)
        cumReqConLen+=int(reqConLen)
        cumRespConLen+=int(respConLen)
      else:
        print string.join([url,status,mimetype,str(timfl),reqHdrLen,reqConLen,respHdrLen,respConLen],",")   
      if int(respConLen)<self.threshold:
        if mimeHistogram.has_key(mimetype):
          mimeHistogram[mimetype]+=int(respConLen)
        else:
          mimeHistogram[mimetype]=int(respConLen)
    
    #done iterating, print any outstanding stuff now
    if currUrl!=None:
      print string.join([currUrl,currStatus,currMimetype,str(currTimfl),str(cumReqHdrLen),str(cumReqConLen),str(cumRespHdrLen),str(cumRespConLen)],",")   
    print
    print "mime type,total response content length"
    for k in mimeHistogram.keys():
      print k,",",mimeHistogram[k]

# create a traffic parser and run a report from it
infile=sys.argv[1]
tp=TrafficParser(infile)
tp.report("\.(php|html)")