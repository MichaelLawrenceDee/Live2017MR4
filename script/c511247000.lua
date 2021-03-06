--Dark Contract with the Eternal Darkness (Anime)
function c511247000.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c511247000.condition)
	e2:SetValue(c511247000.evalue)
	c:RegisterEffect(e2)
	--cannot release
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c511247000.condition)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	c:RegisterEffect(e5)
	local e6=e3:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e6)
	local e7=e3:Clone()
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e7)
	--damage
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(511247000,0))
	e8:SetCategory(CATEGORY_DAMAGE)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e8:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCountLimit(1)
	e8:SetCondition(c511247000.damcon)
	e8:SetTarget(c511247000.damtg)
	e8:SetOperation(c511247000.damop)
	c:RegisterEffect(e8)
end
function c511247000.filter(c)
	return c:IsFaceup() and c:IsCode(511247000)
end
function c511247000.condition(e)
	return not Duel.IsExistingMatchingCard(c511247000.filter,e:GetHandler():GetControler(),0,LOCATION_SZONE,1,nil)
end
function c511247000.evalue(e,re,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and rp~=e:GetHandlerPlayer()
end
function c511247000.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511247000.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c511247000.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
