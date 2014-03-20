package controllers {
	import flash.display.Stage;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.geom.Vector3D;

	// Diz a qualquer momento a inclinação dada pelo telemóvel ou teclado
	public class NetworkController {
		private var socket:Socket;
		private var recvstr:String;
		private var orientationVector:Vector3D;
		private var stage:Stage;
		
		public function NetworkController(s:Stage, hostName:String, port:uint, orientationv:Vector3D) {
			stage = s;
			orientationVector = orientationv;
			startNetworkListener(hostName,port);
		}
		
		public function startNetworkListener(hostName:String, port:uint) : void {
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
			updateOrientation(recvstr);
		}
		
		private function responseHandler(event:ProgressEvent):void {
			readResponse();
		}
		
		private function closeHandler(event:Event):void {
			trace("[DEBUG] Connection lost.");
		}
		
		private function connectHandler(event:Event):void {
			trace("[DEBUG] Connected.");
		}
		
		private function dataHandler(event:DataEvent):void {
			trace("dataHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Controller is offline. Switching to keyboard.");
			var switchController:KeyboardController = new KeyboardController(stage,orientationVector);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function toScale(degrees:int) : Number{
			var output:Number;
			output = degrees;
			return (output-180)/180;
		}
		
		private function updateOrientation(s:String): void {
			try{
				var temp:Array= s.split(";");
				orientationVector.x = toScale(temp[0])
				orientationVector.y = toScale(temp[1]);
				orientationVector.z = toScale(temp[2]);
			}
			catch (error:Error){}
		}
	}
}