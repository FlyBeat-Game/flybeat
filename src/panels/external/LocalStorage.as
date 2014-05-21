package panels.external {
	import flash.filesystem.*;
	
	public class LocalStorage {
		public static function writeObject(obj:Object,filePath:String) : void {
			var file:File = File.applicationStorageDirectory.resolvePath(filePath)
			if (file.exists)
				file.deleteFile()
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.WRITE)
			fileStream.writeObject(obj)
			fileStream.close()
		}
		
		public static function readObject(obj:Object,filePath:String) : Object {
			var file:File = File.applicationStorageDirectory.resolvePath(filePath)
			if (!file.exists)
				return null
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.READ)
			var obj:Object = fileStream.readObject()
			return obj
		}
	}
}