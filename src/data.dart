/// dangry designed by ilshookim
/// MIT License
///
/// https://github.com/ilshookim/dangry
///

/// examples data: 3KB, 10KB, 20KB, 30KB
/// 
dynamic data10KB() {
  return {
    "log": 
    {
      "version": "1.2",
      "creator": {
        "name": "WebInspector",
        "version": "537.36"
      },
      "pages": [
        {
          "startedDateTime": "2021-04-30T11:01:48.509Z",
          "id": "page_1",
          "title": "https://stackoverflow.com/questions/13010354/chunking-websocket-transmission",
          "pageTimings": {
            "onContentLoad": 443.51300003472718,
            "onLoad": 779.8310000216588
          }
        }
      ],
      "entries": 
      [
        {
          "_initiator": {
            "type": "other"
          },
          "_priority": "VeryHigh",
          "_resourceType": "document",
          "cache": {},
          "connection": "217848",
          "pageref": "page_1",
          "request": {
            "method": "GET",
            "url": "https://stackoverflow.com/questions/13010354/chunking-websocket-transmission",
            "httpVersion": "http/2.0",
            "headers": [
              {
                "name": ":method",
                "value": "GET"
              },
              {
                "name": ":authority",
                "value": "stackoverflow.com"
              },
              {
                "name": ":scheme",
                "value": "https"
              },
              {
                "name": ":path",
                "value": "/questions/13010354/chunking-websocket-transmission"
              },
              {
                "name": "cache-control",
                "value": "max-age=0"
              },
              {
                "name": "sec-ch-ua",
                
              },
              {
                "name": "sec-ch-ua-mobile",
                "value": "?0"
              },
              {
                "name": "upgrade-insecure-requests",
                "value": "1"
              },
              {
                "name": "user-agent",
                
              },
              {
                "name": "accept",
                
              },
              {
                "name": "sec-fetch-site",
                "value": "cross-site"
              },
              {
                "name": "sec-fetch-mode",
                "value": "navigate"
              },
              {
                "name": "sec-fetch-user",
                "value": "?1"
              },
              {
                "name": "sec-fetch-dest",
                "value": "document"
              },
              {
                "name": "referer",
                "value": "https://www.google.com/"
              },
              {
                "name": "accept-encoding",
                "value": "gzip, deflate, br"
              },
              {
                "name": "accept-language",
                "value": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7"
              },
              {
                "name": "cookie",
                
              }
            ],
            "queryString": [],
            "cookies": [
              {
                "name": "prov",
                "value": "d9994a63-77a6-1a53-4ce4-8e8c49323588",
                "expires": null,
                "httpOnly": false,
                "secure": false
              },
              {
                "name": "_ga",
                "value": "GA1.2.2109351311.1618379782",
                "expires": null,
                "httpOnly": false,
                "secure": false
              },
              {
                "name": "OptanonAlertBoxClosed",
                "value": "2021-04-14T05:58:18.044Z",
                "expires": null,
                "httpOnly": false,
                "secure": false
              },
              {
                "name": "OptanonConsent",
                
                "expires": null,
                "httpOnly": false,
                "secure": false
              },
              {
                "name": "_gid",
                "value": "GA1.2.627053591.1619763887",
                "expires": null,
                "httpOnly": false,
                "secure": false
              }
            ],
            "headersSize": -1,
            "bodySize": 0
          },
          "response": {
            "status": 200,
            "statusText": "",
            "httpVersion": "http/2.0",
            "headers": [
      
            ],
            "cookies": [],
            "content": {
              "size": 179444,
              "mimeType": "text/html",
              
            },
            "redirectURL": "",
            "headersSize": -1,
            "bodySize": -1,
            "_transferSize": 44131,
            "_error": null
          },
          "serverIPAddress": "151.101.129.69",
          "startedDateTime": "2021-04-30T11:01:48.507Z",
          "time": 410.47400003299119,
          "timings": {
            "blocked": 3.043000008329749,
            "dns": -1,
            "ssl": -1,
            "connect": -1,
            "send": 0.3880000000000001,
            "wait": 226.11400000090897,
            "receive": 180.92900002375246,
            "_blocked_queueing": 1.744000008329749
          }
        },
        {
          "_fromCache": "memory",
          "_initiator": {
            "type": "parser",
            "url": "https://stackoverflow.com/questions/13010354/chunking-websocket-transmission",
            "lineNumber": 23
          },
          "_priority": "High",
          "_resourceType": "script",
          "cache": {},
          "pageref": "page_1",

            "status": 200,
            "statusText": "",
            "httpVersion": "h3-q050",
            "headers": [
              {
                "name": "date",
                "value": "Sun, 25 Apr 2021 05:56:50 GMT"
              },
              {
                "name": "content-encoding",
                "value": "gzip"
              },
              {
                "name": "x-content-type-options",
                "value": "nosniff"
              },
              {
                "name": "age",
                "value": "154324"
              },
              {
                "name": "cross-origin-resource-policy",
                "value": "cross-origin"
              },
              {
                "name": "alt-svc",
                
              },
              {
                "name": "content-length",
                "value": "33951"
              },
              {
                "name": "x-xss-protection",
                "value": "0"
              },
              {
                "name": "last-modified",
                "value": "Tue, 03 Mar 2020 19:15:00 GMT"
              },
              {
                "name": "server",
                "value": "sffe"
              },
              {
                "name": "vary",
                "value": "Accept-Encoding"
              },
              {
                "name": "content-type",
                "value": "text/javascript; charset=UTF-8"
              },
              {
                "name": "access-control-allow-origin",
                "value": "*"
              },
              {
                "name": "cache-control",
                "value": "public, max-age=31536000, stale-while-revalidate=2592000"
              },
              {
                "name": "accept-ranges",
                "value": "bytes"
              },
              {
                "name": "timing-allow-origin",
                "value": "*"
              },
              {
                "name": "expires",
                "value": "Mon, 25 Apr 2022 05:56:50 GMT"
              }
            ],
            "cookies": [],
            "content": {
              "size": 97163,
              "mimeType": "text/javascript",
            
            },
            "redirectURL": "",
            "headersSize": -1,
            "bodySize": 0,
            "_transferSize": 0,
            "_error": null
        },
        {
          "serverIPAddress": "172.217.31.170",
          "startedDateTime": "2021-04-30T11:01:48.781Z",
          "time": 0.109999964479357,
          "timings": {
            "blocked": -1,
            "dns": -1,
            "ssl": -1,
            "connect": -1,
            "send": 0,
            "wait": 0.08699996396899224,
            "receive": 0.02300000051036477,
            "_blocked_queueing": -1
          }
        },
        {
          "_fromCache": "memory",
          "_initiator": {
            "type": "parser",
            "url": "https://stackoverflow.com/questions/13010354/chunking-websocket-transmission",
            "lineNumber": 24
          },
          "_priority": "High",
          "_resourceType": "script",
          "cache": {},
          "connection": "217848",
          "pageref": "page_1",
          "request": {
            "method": "GET",
            "url": "https://cdn.sstatic.net/Js/stub.en.js?v=d0f0ef54ac95",
            "httpVersion": "http/2.0",
            "headers": [
              {
                "name": "sec-ch-ua",
                "value": "\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\", \"Google Chrome\";v=\"90\""
              },
              {
                "name": "Referer",
                "value": "https://stackoverflow.com/"
              },
              {
                "name": "sec-ch-ua-mobile",
                "value": "?0"
              },
              {
                "name": "User-Agent",
                
              }
            ],
            "queryString": [
              {
                "name": "v",
                "value": "d0f0ef54ac95"
              }
            ],
            "cookies": [],
            "headersSize": -1,
            "bodySize": 0
          },
          "response": {
            "status": 200,
            "statusText": "",
            "httpVersion": "http/2.0",
            "headers": [
              {
                "name": "date",
                "value": "Fri, 30 Apr 2021 10:53:15 GMT"
              },
              {
                "name": "content-encoding",
                "value": "gzip"
              },
              {
                "name": "last-modified",
                "value": "Fri, 30 Apr 2021 10:43:10 GMT"
              },
              {
                "name": "age",
                "value": "477"
              },
              {
                "name": "vary",
                "value": "Accept-Encoding,Accept-Encoding"
              },
              {
                "name": "x-cache",
                "value": "HIT"
              },
              {
                "name": "content-type",
                "value": "application/javascript"
              },
              {
                "name": "access-control-allow-origin",
                "value": "stackoverflow.com"
              },
              {
                "name": "cache-control",
                "value": "max-age=604800"
              },
              {
                "name": "x-cache-hits",
                "value": "17"
              },
              {
                "name": "accept-ranges",
                "value": "bytes"
              },
              {
                "name": "x-timer",
                "value": "S1619779996.771621,VS0,VE0"
              },
              {
                "name": "content-length",
                "value": "17834"
              },
              {
                "name": "via",
                "value": "1.1 varnish"
              },
              {
                "name": "x-served-by",
                "value": "cache-itm18820-ITM"
              }
            ],
            "cookies": [],
            "content": {
              "size": 52750,
              "mimeType": "application/javascript",

            },
            "redirectURL": "",
            "headersSize": -1,
            "bodySize": 0,
            "_transferSize": 0,
            "_error": null
          },
          "serverIPAddress": "151.101.129.69",
          "startedDateTime": "2021-04-30T11:01:48.782Z",
          "time": 0.07000000914558768,
          "timings": {
            "blocked": -1,
            "dns": -1,
            "ssl": -1,
            "connect": -1,
            "send": 0,
            "wait": 0.05600001895800233,
            "receive": 0.013999990187585354,
            "_blocked_queueing": -1
          }
        },
        {
          "_fromCache": "memory",
          "_initiator": {
            "type": "parser",
            "url": "https://stackoverflow.com/questions/13010354/chunking-websocket-transmission",
            "lineNumber": 519
          },
          "_priority": "Low",
          "_resourceType": "image",
          "cache": {},
          "pageref": "page_1",
          "request": {
            "method": "GET",
            "url": "https://cdn.sstatic.net/Img/teams/teams-illo-free-sidebar-promo.svg?v=47faa659a05e",
            "httpVersion": "http/2.0",
            "headers": [
              {
                "name": "sec-ch-ua",
                "value": "\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\", \"Google Chrome\";v=\"90\""
              },
              {
                "name": "Referer",
                "value": "https://stackoverflow.com/"
              },
              {
                "name": "sec-ch-ua-mobile",
                "value": "?0"
              },
              {
                "name": "User-Agent",

              }
            ],
            "queryString": [
              {
                "name": "v",
                "value": "47faa659a05e"
              }
            ],
            "cookies": [],
            "headersSize": -1,
            "bodySize": 0
          },


        },

      ]
    }
  };
}
