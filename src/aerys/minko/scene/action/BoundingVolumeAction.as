package aerys.minko.scene.action
{
	import aerys.minko.render.renderer.IRenderer;
	import aerys.minko.scene.node.IScene;
	import aerys.minko.scene.node.mesh.modifier.IMeshModifier;
	import aerys.minko.scene.visitor.ISceneVisitor;
	import aerys.minko.scene.visitor.data.CameraData;
	import aerys.minko.type.bounding.IBoundingVolume;
	
	public class BoundingVolumeAction implements IAction
	{
		private static const TYPE	: uint	= ActionType.UPDATE_LOCAL_DATA;
		
		public function get type() : uint		{ return TYPE;	}
		
		public function prefix(scene : IScene, visitor : ISceneVisitor, renderer : IRenderer) : Boolean
		{
			return true;
		}
		
		public function infix(scene : IScene, visitor : ISceneVisitor, renderer : IRenderer) : Boolean
		{
			var bv 		: IBoundingVolume 	= scene as IBoundingVolume;
			var camData : CameraData 		= visitor.worldData[CameraData] as CameraData;
			
			if (!camData.frustrum.testBoundedVolume(bv, visitor.localData.localToView))
				return false;
			
			visitor.visit((scene as IMeshModifier).target);
			
			return true;
		}
		
		public function postfix(scene : IScene, visitor : ISceneVisitor, renderer : IRenderer) : Boolean
		{
			return true;
		}
	}
}