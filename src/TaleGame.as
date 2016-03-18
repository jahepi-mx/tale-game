package
{
	import com.jahepi.talegame.display.Tale;
	import com.jahepi.talegame.display.components.Button;
	import com.jahepi.talegame.display.components.Component;
	import com.jahepi.talegame.events.ComponentEvent;
	import com.jahepi.talegame.events.TaleEvent;
	import com.jahepi.talegame.events.XMLLoaderEvent;
	import com.jahepi.talegame.loaders.XMLLoader;
	import com.jahepi.talegame.loaders.strategies.ConfigStrategy;
	import com.jahepi.talegame.loaders.strategies.GenreStrategy;
	import com.jahepi.talegame.loaders.strategies.TaleStrategy;
	import com.jahepi.talegame.utils.Registry;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class TaleGame extends Sprite
	{
		private static var XML_BOOT_KEY:String = "boot";
		private static var GENRE_KEY:String = "genre";
		private static var GENRE_FILE:String = "genres.xml";
		private static var CONFIG_FILE:String = "config.xml";
		private static var SERVER_PATH:String = "http://206.51.236.224/test/";
		//private static var SERVER_PATH:String = "";
		
		private var registry:Registry;
		private var xmlRecord:Array;
		private var currentTale:Tale;
		
		public function TaleGame()
		{
			super();
			
			registry = new Registry();
			xmlRecord = new Array();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var strategy:ConfigStrategy = new ConfigStrategy(registry);
			var loader:XMLLoader = new XMLLoader(SERVER_PATH + CONFIG_FILE, strategy);
			loader.addEventListener(XMLLoaderEvent.COMPLETE, onLoadConfig);
			loader.addEventListener(XMLLoaderEvent.ERROR, onError);
			loader.load();
		}
		
		private function onLoadConfig(evt:XMLLoaderEvent):void
		{
			var genre:String = registry.get(GENRE_KEY) as String;
			var genreType:String;
			if(genre == GenreStrategy.MALE_TYPE) {
				genreType = GenreStrategy.MALE_TYPE;
			} else {
				genreType = GenreStrategy.FEMALE_TYPE;
			}
			var strategy:GenreStrategy = new GenreStrategy(genreType, registry);
			var loader:XMLLoader = new XMLLoader(SERVER_PATH + GENRE_FILE, strategy);
			loader.addEventListener(XMLLoaderEvent.COMPLETE, onLoad);
			loader.addEventListener(XMLLoaderEvent.ERROR, onError);
			loader.load();
		}
		
		private function onLoad(evt:XMLLoaderEvent):void 
		{
			loadTale(SERVER_PATH + registry.get(XML_BOOT_KEY) as String);
		}
		
		private function onError(evt:XMLLoaderEvent):void 
		{
			trace(evt.getMessage());
		}
		
		private function loadTale(xml:String):void
		{
			var strategy:TaleStrategy = new TaleStrategy(registry);
			var loader:XMLLoader = new XMLLoader(xml, strategy);
			loader.addEventListener(XMLLoaderEvent.COMPLETE, onLoadTale);
			loader.addEventListener(XMLLoaderEvent.ERROR, onError);
			loader.load();
		}
		
		private function onLoadTale(evt:XMLLoaderEvent):void 
		{
			currentTale = evt.getDataObj() as Tale;
			currentTale.addEventListener(TaleEvent.CHANGE_VIEW, onChangeView);
			currentTale.render();
			addChild(currentTale);
			if(xmlRecord.length > 0) {
				var button:Button = new Button(registry, "Regresar");
				button.addEventListener(ComponentEvent.CHANGE, onBack);
				button.localWidth = 100;
				button.localHeight = 20;
				button.x = button.y = Button.PADDING;
				addChild(button);
			}
			xmlRecord.push(evt.getXmlFilename());
		}
		
		private function onChangeView(evt:TaleEvent):void
		{
			var tale:Tale = evt.target as Tale;
			var file:String = SERVER_PATH + tale.getXMLToLoad();
			loadTale(file);
			removeChild(tale);
		}
		
		private function onBack(evt:ComponentEvent):void
		{
			var currentXML:String = xmlRecord.pop();
			var previousXML:String = xmlRecord.pop();
			removeChild(currentTale);
			removeChild(evt.target as Component);
			loadTale(previousXML);
		}
	}
}