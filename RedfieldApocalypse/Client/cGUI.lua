function guiCreateNewWindow(x,y,w,h,text,relative,nocross)
	local window = guiCreateStaticImage(x,y,w,h,"Files/Images/Window1.png",relative)
	local balken = guiCreateStaticImage(0,0,w,20,"Files/Images/Window2.png",relative,window)
	local label = guiCreateLabel(0,0,w,20,text,relative,window)
	guiSetFont(label,"default-bold-small")
	guiLabelSetHorizontalAlign(label,"center",true)
	guiLabelSetVerticalAlign(label,"center")
	
	if(not(nocross))then
		close = guiCreateStaticImage(3,3,15,15,"Files/Images/Cross.png",relative,window)
		addEventHandler("onClientGUIClick",close,function()
			setWindowDatas("reset")
		end,false)
	end
	
	return window
end
guiCreateWindow = guiCreateNewWindow

function guiCreateNewButton(x,y,w,h,text,relative,parent)
	local button = guiCreateStaticImage(x,y,w,h,"Files/Images/Window2.png",relative,parent)
	local label = guiCreateLabel(x,y,w,h-3,text,relative,parent)
	guiCreateStaticImage(x,y,w,1,"Files/Images/WhitePxl.png",relative,parent)
	guiCreateStaticImage(x+w-1,y,1,h,"Files/Images/WhitePxl.png",relative,parent)
	guiCreateStaticImage(x,y+h-1,w,1,"Files/Images/WhitePxl.png",relative,parent)
	guiCreateStaticImage(x,y,1,h,"Files/Images/WhitePxl.png",relative,parent)
	guiSetFont(label,"default-bold-small")
	guiLabelSetHorizontalAlign(label,"center",true)
	guiLabelSetVerticalAlign(label,"center")
	
	return label
end
guiCreateButton = guiCreateNewButton