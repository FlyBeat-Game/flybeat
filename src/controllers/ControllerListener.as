package controllers {
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Vector3D;
	import flash.net.Socket;

	// Diz a qualquer momento a inclinação dada pelo telemóvel ou teclado
	public class ControllerListener {
		private var hostName:String = "localhost";
		private var port:uint = 8087;
		private var socket:Socket;
		private var recvstr:String;
		private var orientationv:Vector3D;
		public var controller:String = "remote";
		
		public function ControllerListener()
		{
			orientationv = new Vector3D(0,0,0);
			if (controller == "remote") startNetworkListener();
			else trace("keyboard");
		}
		
		/*BEGIN NETWORK SHIT*/
		public function startNetworkListener() : void {
			trace("Using network controller");
			socket = new Socket();
			configListeners(socket);
			if (hostName && port) socket.connect(hostName, port);
			socket.writeUTF("start");
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
			trace("[DEBUG NC] response: \"" + recvstr + "\"");
			updateOrientation(recvstr);
		}
		
		private function responseHandler(event:ProgressEvent):void {
			readResponse();
		}
	
		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
		}
		
		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
		}
		
		private function dataHandler(event:DataEvent):void {
			trace("dataHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		/*END NETWORK SHIT*/
		
		/*BEGIN KEYBOARD SHIT*/
		//TODO
		/*END KEYBOARD SHIT*/
		
		private function toScale(degrees:int) : Number{
			var output:Number;
			output = degrees;
			return (output-180)/180;
		}
		
		private function updateOrientation(s:String): void {
			try{
				var temp:Array= s.split(";");
				var x:Number = toScale(temp[0]);
				var y:Number = toScale(temp[1]);
				var z:Number = toScale(temp[2]);
				trace(x + " - " + y + " - " + z);
			}
			catch (error:Error){}
		}
		
		// Todos os valores entre -1 e 1
		public function getOrientation() : Vector3D {
			return orientationv;
		}
	}
}