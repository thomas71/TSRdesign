﻿package com.flickr{	import flash.display.*;	import flash.events.*;	import flash.net.*;	import flash.system.LoaderContext;				public class Load_image extends MovieClip	{				private var loader:Loader;		private var preloaderMC:preloader = new preloader();								public function Load_image()		{			addChild(preloaderMC);		}						public function loadImage(image:String):void		{			var context:LoaderContext = new LoaderContext();			context.checkPolicyFile = true;						loader = new Loader();			configureListeners(loader.contentLoaderInfo);			loader.load(new URLRequest(image), context);		}								private function configureListeners(dispatcher:IEventDispatcher):void		{			dispatcher.addEventListener(Event.COMPLETE, completeHandler);			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);        }								private function progressHandler(e:ProgressEvent):void		{			var percent:int = Math.ceil((e.bytesLoaded * 100) / e.bytesTotal);			preloaderMC.txt.text = String(percent);        }								private function completeHandler(e:Event):void		{			removeChild(preloaderMC);						var bitmap:Bitmap = Bitmap(e.target.loader.content);						bitmap.smoothing = true;			addChild(loader);		}	}}