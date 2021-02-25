function CreateStatus(name, default, color, reverse, visible, tickCallback)
		
	local self = {}

	self.val          = default
	self.percent 	  = round((self.val / Config.StatusMax) * 100)
	self.name         = name
	self.default      = default
	self.reverse 	  = reverse
	self.color        = color
	self.visible      = visible
	self.tickCallback = tickCallback

	self._set = function(k, v)
		self[k] = v
	end

	self._get = function(k)
		return self[k]
	end

	self.onTick = function()
		self.tickCallback(self)
	end

	self.set = function(val)
		self.val = val
		self.updatePercent()
	end

	self.add = function(val)
		if self.val + val > Config.StatusMax then
			self.val = Config.StatusMax
		elseif self.val + val < 0 then
			self.val = 0
		else
			self.val = self.val + val
		end
		self.updatePercent()
	end

	self.remove = function(val)
		if self.val - val < 0 then
			self.val = 0
		else
			self.val = self.val - val
		end
		self.updatePercent()
	end
	self.updatePercent = function()
		local previousPercenr = self.percent
		self.percent = round((self.val / Config.StatusMax) * 100)
		if(previousPercenr ~= self.percent)then
			TriggerEvent("esx_status:onPercentageChanged", self)
		end
	end
	return self

end
