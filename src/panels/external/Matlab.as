package panels.external {	
	import flash.desktop.NativeApplication;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import common.Game;
	
	import panels.Panel;
	
	public class Matlab{
		private var socket:Socket
		private var recvstr:String
		private const port:int = 8086
		private var panel:Panel
		
		public function Matlab(panel:Panel) {
			this.panel = panel
			startMatlabAnalyzer("localhost", port)
		}
		
		public function startMatlabAnalyzer(hostName:String, port:uint) : void {
			socket = new Socket()
			socket.timeout = 500
			configListeners(socket)
			if (hostName && port) socket.connect(hostName, port)
		}
		
		private function configListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.CLOSE, closeHandler)
			dispatcher.addEventListener(Event.CONNECT, connectHandler)
			dispatcher.addEventListener(DataEvent.DATA, dataHandler)
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler)
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler)
			dispatcher.addEventListener(ProgressEvent.SOCKET_DATA, responseHandler)
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler)
		}
		
		private function readResponse():void{
			recvstr = socket.readUTFBytes(socket.bytesAvailable)
			var s:Array = recvstr.split(";")
			var bpm:int = parseInt(s[0])
			var notes:Array = parseArray(s[1])
			var energy:Array = parseArray(s[2])
			
			Game.bpm = bpm
			Game.notes = notes
			Game.energy = energy
			
			trace(bpm)
			
			panel.stage.dispatchEvent(new Event("buildMap"))
		}
		
		private function responseHandler(event:ProgressEvent):void {
			readResponse()
		}
		
		private function closeHandler(event:Event):void {
			/*if (Game.notes == null)
				startMatlabAnalyzer("localhost", port)*/
		}
		
		private function connectHandler(event:Event):void {
			trace("[MATLAB] Connected to Matlab server.")
		}
		
		private function dataHandler(event:DataEvent):void {	}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			matlabError()
		}
		
		private function progressHandler(event:ProgressEvent):void { }
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			matlabError()
		}
		
		private function matlabError():void{
			trace("Matlab module is not running. Aborting...")
			// NativeApplication.nativeApplication.exit()
		}
		
		private function parseArray(s:String):Array{
			if (s == null) return null
			var n:Array = new Array()
			n = s.split(",")
			for (var i:int=0;i<n.length;i++){
				n[i] = toScale(n[i])
			}
			return n
		}
		
		private function toScale(note:int):Number{
			return ((note-1)*2/13)-1
		}
		
		public function sendFilename(filename:String):void{
			socket.writeUTF(filename)
			socket.flush()
		}
	}
}
