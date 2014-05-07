package networking
{	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	public class Matlab {
		private var socket:Socket;
		private var recvstr:String;
		private const port:int = 8086;
		private var notes:Array;
		private var filename:String;
		
		public function Matlab(filename:String) {
			filename = filename;
			startMatlabAnalyzer("localhost",port);
		}
		
		public function startMatlabAnalyzer(hostName:String, port:uint) : void {
			socket = new Socket();
			socket.timeout = 500;
			configListeners(socket);
			if (hostName && port) socket.connect(hostName, port);
		}
		
		private function configListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.CLOSE, closeHandler);
			dispatcher.addEventListener(Event.CONNECT, connectHandler);
			dispatcher.addEventListener(DataEvent.DATA, dataHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(ProgressEvent.SOCKET_DATA, responseHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		
		private function readResponse():void{
			recvstr = socket.readUTFBytes(socket.bytesAvailable);
			notes = parseArray(recvstr);
			trace(notes);
		}
		
		private function responseHandler(event:ProgressEvent):void {
			readResponse();
		}
		
		private function closeHandler(event:Event):void {
			trace("[DEBUG MATLAB] Done.");
		}
		
		private function connectHandler(event:Event):void {
			trace("[DEBUG MATLAB] Connected to Matlab server.");
			socket.writeUTF("music120.mp3");
			socket.flush();
		}
		
		private function dataHandler(event:DataEvent):void {
			trace("dataHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Network error. Aborting...");
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("Matlab module is offline. Aborting...");
		}
		
		private function parseArray(s:String):Array{
			var n:Array = s.split("  ");
			for (var i:int=0;i<n.length;i++){
				n[i] = toScale(n[i]);
			}
			return n;
		}
		
		private function toScale(note:int):Number{
			return ((note-1)*2/12)-1;
		}
		
		public function getNotes():Array{
			return notes;
		}
		
		public function getLength():int{
			if (notes == null) return 0;
			return notes.length;
		}
	}
}
