package
{
	import com.codezen.helper.WebWorker;
	import com.codezen.music.playr.PlayrTrack;
	import com.codezen.music.search.ISearchProvider;
	
	public class Searcher extends WebWorker implements ISearchProvider
	{
		// results array
		private var _result:Vector.<PlayrTrack>;
		
		public function Searcher()
		{
			super();
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
			_result = new Vector.<PlayrTrack>();
			
			
		}
		
		
	}
}