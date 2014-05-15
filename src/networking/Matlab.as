package networking
{	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import panels.Panel;
	
	public class Matlab{
		private var socket:Socket;
		private var recvstr:String;
		private const port:int = 8086;
		private var notes:Array;
		private var bpm:int;
		private var energy:Array;
		private var panel:Panel;
		
		public function Matlab(panel:Panel) {
			this.panel = panel;
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
			var s:Array = recvstr.split(";");
			bpm = parseInt(s[0]);
			notes = parseArray(s[1]);
			energy = parseArray(s[2]);
			
			trace(bpm);
			trace(notes);
			trace(energy);
			
			panel.stage.dispatchEvent(new Event("matlabComplete"));
		}
		
		private function responseHandler(event:ProgressEvent):void {
			readResponse();
		}
		
		private function closeHandler(event:Event):void {
			trace("[DEBUG MATLAB] Done.");
			if (notes == null) musicNotesError();
			startMatlabAnalyzer("localhost",port);
		}
		
		private function connectHandler(event:Event):void {
			trace("[DEBUG MATLAB] Connected to Matlab server.");
		}
		
		private function dataHandler(event:DataEvent):void {
			trace("dataHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Matlab module is offline. Aborting...");
			musicNotesError();
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("Security error. Aborting...");
			musicNotesError();
		}
		
		private function musicNotesError():void{
			if (notes == null) panel.stage.dispatchEvent(new Event("musicNotesError"));
		}
		
		private function parseArray(s:String):Array{
			var n:Array = s.split("  ");
			for (var i:int=0;i<n.length;i++){
				n[i] = toScale(n[i]);
			}
			return n;
		}
		
		private function toScale(note:int):Number{
			return ((note-1)*2/13)-1;
		}
		
		public function getBPM():int{
			return bpm;
		}
		
		public function getNotes():Array{
			return notes;
		}
		
		public function getEnergy():Array{
			return energy;
		}
		
		public function sendFilename(filename:String):void{
			socket.writeUTF(filename);
			socket.flush();
		}
	}
}
