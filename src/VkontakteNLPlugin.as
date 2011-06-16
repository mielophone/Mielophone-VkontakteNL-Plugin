package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class VkontakteNLPlugin extends Sprite
	{
		private var s:Searcher;
		public function VkontakteNLPlugin()
		{
			s = new Searcher();
			//test();
		}
		
		private function test():void{
			//var t:Timer = new Timer(1000,1);
			//t.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:Event):void{
			//s.addEventListener(Event.COMPLETE, function(e:Event):void{
				///trace( s.result );
			//});
			s.search("muse take a bow");
			//});
			//t.start();
		}
	}
}