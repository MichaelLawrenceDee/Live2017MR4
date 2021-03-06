--オーバー・デッド・ライン
function c511003005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511003005.acttg)
	c:RegisterEffect(e1)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c511003005.atktg)
	e3:SetValue(1000)
	c:RegisterEffect(e3)
end
function c511003005.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c511003005.descon)
	e1:SetOperation(c511003005.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(1082946)
	e2:SetLabelObject(e1)
	e2:SetOwnerPlayer(tp)
	e2:SetOperation(c511003005.reset)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	c:RegisterEffect(e2)
	c:SetTurnCounter(0)
end
function c511003005.reset(e,tp,eg,ep,ev,re,r,rp)
	c511003005.desop(e:GetLabelObject(),tp,eg,ep,ev,e,r,rp)
end
function c511003005.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511003005.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()+1
	c:SetTurnCounter(ct)
	if ct==2 then
		Duel.Destroy(c,REASON_EFFECT)
		if re and re.Reset then re:Reset() end
	end
end
function c511003005.atktg(e,c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsPreviousLocation(LOCATION_GRAVE)
end
