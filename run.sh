#!/bin/bash
echo 'begin 开始' >>/run.log
date >>/run.log
/opt/dbforbix/dbforbix.sh start >>/run.log
date >>/run.log
/opt/dbforbix/dbforbix.sh restart >>/run.log 
date >>/run.log
echo 'end 结束' >>/run.log
