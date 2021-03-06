--Lightforce Sword
function c511600004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511600004.target)
	e1:SetOperation(c511600004.activate)
	c:RegisterEffect(e1)
end
function c511600004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_HAND)
end
function c511600004.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local rs=g:Select(tp,1,1,nil)
	local card=rs:GetFirst()
	if card==nil then return end
	if Duel.Remove(card,POS_FACEDOWN,REASON_EFFECT)>0 and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,4)
		e1:SetCondition(c511600004.thcon)
		e1:SetOperation(c511600004.thop)
		e1:SetLabel(1)
		card:RegisterEffect(e1)
		local descnum=tp==c:GetOwner() and 0 or 1
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetDescription(aux.Stringid(49587034,descnum))
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
		e3:SetCode(1082946)
		e3:SetLabelObject(e1)
		e3:SetOwnerPlayer(tp)
		e3:SetOperation(c511600004.reset)
		e3:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,4)
		c:RegisterEffect(e3)
	end
end
function c511600004.reset(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetLabelObject() then e:Reset() return end
	c511600004.thop(e:GetLabelObject(),tp,eg,ep,ev,e,r,rp)
end
function c511600004.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511600004.thop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()+1
	e:GetOwner():SetTurnCounter(ct)
	e:SetLabel(ct+1)
	if ct==3 then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		if re and re.Reset then re:Reset() end
	end
end
