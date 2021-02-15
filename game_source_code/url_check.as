var $amd, $bmd, $cmd;
//$amd = _url.substr(0, _url.indexOf(":"));
//if ($amd == "http") {
$bmd = _url.indexOf("//");
$cmd = _url.substr($bmd+2, _url.indexOf("/", $bmd+2)-$bmd-2);
$cmd = $cmd.toLowerCase();

if ($cmd.indexOf("www.skylogic.ca") != -1) {
	$cmd = $cmd.substr($cmd.indexOf("www.skylogic.ca")+4, $cmd.length);
}
if ($cmd.indexOf("skylogic.ca") == -1) {
	gotoAndStop("sitewarning");
	return;
}
//} else {
//	gotoAndStop("sitewarning");
//	urlTxt=_url;
//	return;
//}