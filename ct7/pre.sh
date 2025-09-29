#删除.o文件，避免编译中间文件的混乱
targetpath=$PWD
cd ..
rm $(find ./ -name *.o)
cd target

cp ../source/commlib/frd_frame/lib/package.des.linux ../source/commlib/frd_frame/lib/package.des
cp ../source/commlib/frd_frame/dll/package.des.linux ../source/commlib/frd_frame/dll/package.des
cp ../source/commlib/frd_extern/package.des.linux ../source/commlib/frd_extern/package.des
cp ../source/commlib/deepsupervise/package.des.linux ../source/commlib/deepsupervise/package.des
cp ../source/commlib/openssl/package.des.linux ../source/commlib/openssl/package.des
cp ../source/commlib/sqlapi/package.des.linux ../source/commlib/sqlapi/package.des
cp ../source/settlementcore/package.des.linux ../source/settlementcore/package.des

cp ../target/rmskernel/rmskernel.prj.linux ../target/rmskernel/rmskernel.prj
cp ../target/rmsprediction/rmsprediction.prj.linux ../target/rmsprediction/rmsprediction.prj
cp ../target/rmsfront/rmsfront.prj.linux ../target/rmsfront/rmsfront.prj
cp ../target/rmssecfront/rmssecfront.prj.linux ../target/rmssecfront/rmssecfront.prj
cp ../target/rmsstdfront/rmsstdfront.prj.linux ../target/rmsstdfront/rmsstdfront.prj
cp ../target/rmstinit/rmstinit.prj.linux ../target/rmstinit/rmstinit.prj
cp ../target/rmstmdb/rmstmdb.prj.linux ../target/rmstmdb/rmstmdb.prj
cp ../target/rmsuserapi/rmsuserapi.prj.linux ../target/rmsuserapi/rmsuserapi.prj
cp ../target/riskapimgr/riskapimgr.prj.linux ../target/riskapimgr/riskapimgr.prj
cp ../target/dataxcenterapimgr/dataxcenterapimgr.prj.linux ../target/dataxcenterapimgr/dataxcenterapimgr.prj
cp ../target/rmscompositor/rmscompositor.prj.linux ../target/rmscompositor/rmscompositor.prj
cp ../target/priceestimator/priceestimator.prj.linux ../target/priceestimator/priceestimator.prj
cp ../target/rmssettle/rmssettle.prj.linux ../target/rmssettle/rmssettle.prj
cp ../target/foxgateway/foxgateway.prj.linux ../target/foxgateway/foxgateway.prj
cp ../target/ctpriskapimgr/ctpriskapimgr.prj.linux ../target/ctpriskapimgr/ctpriskapimgr.prj
cp ../target/business/estimate/estimate.prj.linux ../target/business/estimate/estimate.prj
cp ../target/rmspe/rmspe.prj.linux ../target/rmspe/rmspe.prj
cp ../target/rmsdscmgr/rmsdscmgr.prj.linux ../target/rmsdscmgr/rmsdscmgr.prj

rm -rf ../source/commlib/frd_frame/lib/libcffexfrdframe.a
rm -rf ../source/commlib/frd_frame/dll/libcffexfrdframe.so
rm -rf ../source/commlib/frd_extern/libfrdframeextern.a
cd ../source/commlib/frd_frame/lib
ln -s libcffexfrdframe.a.* libcffexfrdframe.a
cd ../dll
ln -s libcffexfrdframe.so.* libcffexfrdframe.so
cd ../../frd_extern/
ln -s libfrdframeextern.a.* libfrdframeextern.a
cd ../../../target/

rm -rf ../source/DataXCenterApi/libFIPDataXCenterComApi.so
rm -rf ../source/DataXCenterApi/libFIPDataXCenterInnerCodecApi.so
cd ../source/DataXCenterApi/
ln -s libFIPDataXCenterComApi_linux.so libFIPDataXCenterComApi.so
ln -s libFIPDataXCenterInnerCodecApi_linux.so libFIPDataXCenterInnerCodecApi.so

rm -rf ../settlementcore/libsettlecore.so
cd ../settlementcore/
ln -s libsettlecore_linux.so libsettlecore.so

rm -rf ../DsFrontComApi/libDsFrontComApi.so
cd ../DsFrontComApi/
ln -s libDsFrontComApi_linux.so libDsFrontComApi.so

cd ../ustpmduserapi/
rm -rf libUSTPmduserapiFM.so
ln -s libUSTPmduserapiFM_linux.so libUSTPmduserapiFM.so

cd ../ustpriskapi/
rm -rf libUSTPriskapiFM.so
ln -s libUSTPriskapiFM_linux.so libUSTPriskapiFM.so

cd ../riskcommlib/muparser/
rm -rf libmuparser.so
ln -s libmuparser_linux.so libmuparser.so

cd ../curl/
rm -rf libcurl.so
ln -s libcurl_linux.so libcurl.so

cd ../../../target/

pushd ../../05TradeFiles/encryptapi
rm -rf libfemasunifiedcodec.lib.a
rm -rf libfemasunifiedcodec.so
ln -fs libfemasunifiedcodec_linux.lib.a libfemasunifiedcodec.lib.a
ln -fs libfemasunifiedcodec_linux.so libfemasunifiedcodec.so
popd

#将此刻的时间变成编译version的时间
if test A$1 != A-v; then
    chmod +w ../source/version/versionValue.h
    echo const char *version=\"$(date +%Y%m%d.%H:%M:%S)\"\; >../source/version/versionValue.h
    echo const char *femas_rms_version=\"$1\"\; >>../source/version/versionValue.h
fi

#hpux和linux的编译设置，不同的环境按不同的方式编译
#os=`uname`
#if [ "$os" = "Linux" ]
#then
#	chmod u+x mall.linux
#	./mall.linux
#else
#	if [ "$os" = "HP-UX" ]
#	then
#		chmod u+x mall.hpux
#		./mall.hpux
#	fi
#fi

#先编译api，清理掉之前编译的32位的数据
#for project in rmsuserapi
#do
#    echo make $project
#    cd $project
#    amake $project.prj
#	make clean
#    make
#    cd ..
#done

#当前包含模块：rmsfront rmssecfront rmsstdfront rmskernel rmstinit rmstmdb rmsprediction rmsuserapi riskapimgr dataxcenterapimgr rmscompositor rmsarb priceestimator rmssettle foxgateway ctpriskapimgr rmspe rmsdscmgr rmsstdsecfront
#清理所有模块并 pump
for project in rmstinit rmskernel rmsfront rmssecfront rmsstdfront rmstmdb rmsuserapi rmsprediction riskapimgr dataxcenterapimgr rmscompositor rmsarb priceestimator rmssettle foxgateway ctpriskapimgr rmspe rmsdscmgr rmsstdsecfront; do
    echo clean $project
    cd $targetpath/$project
    amake $project.prj
    make clean && make pump
done

# 生成动态库的 makefile
# clean 并且 pump
for project in estimate; do
    echo clean business $project
    cd $targetpath/business/$project
    amake $project.prj
    make clean && make pump
done

#生成编译工具的 makefile 并 clean
for project in flowviewer stdflowviewer flowchk slogparser dumptool accounttool tcpudptool encryptiontool genprivatekeybase64 testcrypt pricediff riskmonitor risklatencytool; do
    echo make $project
    cd $targetpath/../tools/$project
    amake $project.prj
    make clean && make pump
done

cd $targetpath/../tools/gtest/main
amake test.prj
make clean && make pump
cd $targetpath
