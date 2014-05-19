package panels.widgets
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import panels.widgets.NormalText;
	
	public class ScoreDisplay extends Sprite
	{
		public function ScoreDisplay(beatScore:Number,song:String,score:Number,stageWidth:Number)
		{
			beatsBorder = addChild(new BeatsBorder)
			
			songName = addChild(new NormalText(song.toString(),14))
			songScore = addChild(new NormalText(score.toString(),14))
			var fill:Bitmap = new BeatsFill
			fill.mask = beatsMask
			
			beatsFill.addChild(fill)
			beatsFill.x += 2
			beatsFill.y +=2
			
			beatsMask.graphics.clear()
			beatsMask.graphics.beginFill(0xffffff)
			beatsMask.graphics.drawRect(0, 0, beatsFill.width * beatScore / 100, beatsFill.height)
			beatsMask.graphics.endFill()
			
		 	
			songName.x = (stageWidth - songName.width)/2
			songName.y = beatsBorder.height/2 - songName.height/2
				
			songScore.x= stageWidth-songScore.width
			songScore.y= beatsBorder.height/2 - songName.height/2
			
			
		}
		
		var beatsBorder, beatsFill = addChild(new Sprite)
		var beatsMask = beatsFill.addChild(new Shape)
		var songName,songScore;
		
		[Embed(source = "../../../media/Fuel-Border.png", mimeType = "image/png")]
		public var BeatsBorder:Class;
		
		[Embed(source = "../../../media/Beats-Fill.png", mimeType = "image/png")]
		public var BeatsFill:Class;
		
		
	}
}