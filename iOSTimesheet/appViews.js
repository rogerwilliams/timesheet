{
    "_id": "_design/appViews",
    "_rev": "1-2ad0b3cf10b27326d4efa8c9ab445817",
    "language": "javascript",
    "views": {
        "timesheetByUser": {
            "map": "
            function(doc) {
                if(doc.type=='timesheet') { 
                    emit([doc.userid,doc.timestamp], doc);
                }
            }"
        }
    }
}