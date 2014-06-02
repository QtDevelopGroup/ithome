// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
//import XmlListModel 1.0
AddXmlModel{
    id:xmlModel
    property string verifyKey
    query: "/rss/channel/item"
    function beginPost(url,key)
    {
        //loading=true
        verifyKey=key
        source=url
        xmlModel.reload()
    }
    onStatusChanged: {
        //console.log("xmlModel status:"+status)
        if(status==XmlListModel.Ready&&count>0)
        {
            var temp=Number(xmlModel.get(0).newsid)
            for(var i=0;i<xmlModel.count;++i){
                //console.log("re sid:"+xmlModel.get(i).newsid)
                //cacheContent.saveTitle(xmlModel.get(i).newsid,xmlModel.get(i).title)
                //cacheContent.saveContent(xmlModel.get(i).newsid,xmlModel.get(i).detail)
                if(verifyKey!=zone) return
                listmodel.append({
                             "title":xmlModel.get(i).title,
                             "m_url":xmlModel.get(i).m_url,
                             "image":xmlModel.get(i).image,
                             "description":xmlModel.get(i).description,
                             "detail":xmlModel.get(i).detail,
                             "newsid":xmlModel.get(i).newsid,
                             "hitcount":xmlModel.get(i).hitcount,
                             "commentcount":xmlModel.get(i).commentcount,
                             "postdate":xmlModel.get(i).postdate,
                             "newssource":xmlModel.get(i).newssource,
                             "newsauthor":xmlModel.get(i).newsauthor,
                             "isHighlight":false,
                             "m_text":""
                            })

            }

            if(temp>maxnewsidData)
                maxnewsidData=temp
            if(Number(xmlModel.get(count-1).newsid)<minnewsidData)
            {
                minnewsidData=Number(xmlModel.get(count-1).newsid)
                //console.log("min sid="+minnewsidData)
            }
            if(zone!="favorite"&isOneStart)
            {
                addxmlmodel.source="http://www.ithome.com/rss/"+zone+"lessthan_"+String(minnewsidData)+".xml"
                addxmlmodel.query="/rss/channel/item"
                addxmlmodel.reload()
                isOneStart=false
            }
            loading=false
        }
        else if(status==XmlListModel.Loading)
        {
            //console.log("xmlModel status:Loading,post url="+xmlModel.source)
            loading=true
        }
    }
}
