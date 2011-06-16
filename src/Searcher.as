package
{
	import com.codezen.helper.WebWorker;
	import com.codezen.music.playr.PlayrTrack;
	import com.codezen.music.search.ISearchProvider;
	import com.codezen.util.MD5;
	
	import flash.events.Event;
	
	import mx.utils.StringUtil;
	
	public class Searcher extends WebWorker implements ISearchProvider
	{
		// results array
		private var _result:Vector.<PlayrTrack>;
		
		// limit of duration
		private var _finddur:int;
		//artist|track
		private var _query:String;
		
		public function Searcher()
		{
			super();
			
			urlRequest.requestHeaders['Referer'] = "http://vkontakte.ru/";
		}
		
		public function get PLUGIN_NAME():String{
			return "Vkontakte API NoLogin MP3 Search";
		}
		
		public function get AUTHOR_NAME():String{
			return "yamalight";
		}
		
		public function get result():Vector.<PlayrTrack>{
			return _result;
		}
		
		public function search(query:String, durationMs:int = 0):void{			
			var md5hash:String;
			var apiKeys:Array = new Array();
			apiKeys[0] = "1878252:bWljxaglcm";
			apiKeys[1] = "1878257:iXeOzlqBqL";
			apiKeys[2] = "1878261:nrwqj8lvTH";
			apiKeys[3] = "1878262:QPQWOeSlJ7";
			apiKeys[4] = "1878263:tnIn7jFh4C";
			apiKeys[5] = "1878266:GkKToIOjGW";
			apiKeys[6] = "1878267:dBbcueh4JW";
			apiKeys[7] = "1878268:vOrc2D0oxh";
			apiKeys[8] = "1878269:NJTjZds8Rc";
			apiKeys[9] = "1878270:a0LUh2Kmrg";
			apiKeys[10] = "1878273:mv89KKdvly";
			apiKeys[11] = "1878274:DPtkr3dLdm";
			apiKeys[12] = "1878275:92vTCPHjbm";
			apiKeys[13] = "1878276:O3TJyO4Tmg";
			apiKeys[14] = "1878277:xH2j6KCvxi";
			apiKeys[15] = "1878286:pHpMrvogSs";
			apiKeys[16] = "1878287:k6BO29WRRS";
			apiKeys[17] = "1878289:Aq6ALH66zw";
			apiKeys[18] = "1878290:svh5NWj4EW";
			apiKeys[19] = "1878291:FTalzIN88Z";
			var i:int = Math.round(Math.random()*19);
			var resutArr:Array = apiKeys[i].toString().match(/(\d+):(.+)/);
			var apiId:String = resutArr[1];
			var apiKey:String = resutArr[2];
			
			var cnt:int=20;
			md5hash =  MD5.encrypt('61745456api_id='+apiId+'count='+cnt+'method=audio.searchq='+query+'test_mode=1'+apiKey);
			urlRequest.url =  'http://api.vkontakte.ru/api.php?api_id='+apiId+'&count='+cnt+'&method=audio.search&sig='+md5hash+'&test_mode=1&q='+query;						
			
			myLoader.addEventListener(Event.COMPLETE, onResults);
			
			// set duration
			_finddur = durationMs;
			//set params
			_query = query;
			
			// load request
			myLoader.load(urlRequest);
			
		}
		
		/**
		 * 
		 * @param evt
		 * Result parser on recieve
		 */
		private function onResults(evt:Event):void{
			// add event listener and load url
			myLoader.removeEventListener(Event.COMPLETE, onResults);
			// get result data
			var data:String = String(evt.target.data);
			
			// reset results
			_result = new Vector.<PlayrTrack>();
			
			// create temp vars
			var dur:int;
			var songs:XML;
			var track:PlayrTrack;
			
			var dataXML:XML = new XML(evt.target.data);
			var songsList:XMLList;
			songsList = dataXML.audio;
			
			for each(songs in songsList){
				dur = int(songs.duration)*1000;
				
				track = new PlayrTrack();
				track.title = StringUtil.trim(songs.title);
				track.artist = StringUtil.trim(songs.artist);
				track.file = songs.url;
				track.totalSeconds = dur/1000;
				
				if(_finddur != 0){
					if( Math.floor(_finddur - dur) < 1000 ){
						_result.push(track);
					}
				}else{
					_result.push(track);
				}
			}
			
			
			// end
			endLoad()
		}
		
	}
}