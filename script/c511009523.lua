--Supreme King Brutality
--fixed by MLD
function c511009523.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009523.condition)
	e1:SetTarget(c511009523.target)
	e1:SetOperation(c511009523.activate)
	c:RegisterEffect(e1)
end
function c511009523.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf8)
end
function c511009523.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009523.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009523.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 
		and Duel.IsExistingMatchingCard(c511009523.cfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511009523.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	local ct=Duel.GetMatchingGroupCount(c511009523.cfilter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	if g:GetCount()>0 then
		Duel.ConfirmCards(p,g)
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_DISCARD)
		local sg=g:Select(p,1,ct,nil)
		local dt=Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		if dt~=0 then
			Duel.Damage(1-p,dt*300,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-p)
	end
end
