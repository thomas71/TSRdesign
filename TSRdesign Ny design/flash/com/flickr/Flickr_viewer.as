package com.flickr
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.Security;
    import flash.system.SecurityPanel;
	import flash.system.LoaderContext;
	
	
	
	public class Flickr_viewer extends MovieClip
	{		
		private var yourAPIKey:String = "22e6ad8aef97d7f74e0fdb7b24191e6f"; // YOUR FLICKR API KEY. THIS CAN BE OBTAINED FROM - http://www.flickr.com/services/
		private var yourNSID:String = "34299724@N06"; // YOUR FLICKR NSID NUMBER. THIS CAN BE FOUND HERE - http://www.flickr.com/services/api/explore/?method=flickr.people.getInfo
		
		private var imageQty:Number = 10;	// THE AMOUNT OF THUMBNAILS YOU WANT TO DISPLAY.
		private var imageGap:Number = 80;	// THE GAP BETWEEN EACH THUMBNAIL
		private var imageYpos:Number = 40;	// THE Y POSITION OF EACH THUMBNAIL
		
		private var xml:XML;
		private var xml_url:URLRequest;
		private var xml_loader:URLLoader;
		private var imageList:XMLList;
		private var loader:Loader;
		
		
		
		
		public function Flickr_viewer()
		{
			Security.allowDomain("*", "api.flickr.com");
			loadXML("http://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=" + yourAPIKey + "&user_id=" + yourNSID);
			xml_loader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		
		
		private function loadXML(url:String):void
		{
			xml = new XML();
			xml_url = new URLRequest(url);
			xml_loader = new URLLoader(xml_url);
		}
		
		
		
		private function xmlLoaded(e:Event):void
		{
			xml = XML(xml_loader.data);
			imageList = xml.photos.*;

			var xpos:Number = 0;
			
			for (var i:uint = 0; i < imageQty; i++)
			{
				var image:XML = imageList[i];
				var flickrImage:String = "http://farm" + image.@farm + ".static.flickr.com/" + image.@server + "/"+ image.@id + "_" + image.@secret + "_s.jpg";
				
				var thumb:MovieClip = new thumbnail();
				thumb.id = image.@id;
				thumb.image_owner = image.@owner;
				thumb.x = xpos;
				thumb.y = imageYpos;
				xpos += imageGap;
				
				thumb.loadImage(flickrImage);
				
				thumb.useHandCursor = true;
				thumb.buttonMode = true;
				thumb.mouseChildren = false;
				thumb.addEventListener(MouseEvent.CLICK, btnClick);
				
				addChild(thumb);
			}
		}
		
		
		
		private function btnClick(e:Event):void
		{
			var url:String = "http://www.flickr.com/photos//" + e.target.image_owner + "/" + e.target.id;
			var req:URLRequest = new URLRequest(url);
			navigateToURL(req, "_blank");
		}
	}
}




















