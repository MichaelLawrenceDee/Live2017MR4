--Otonari Thunder
--  By Shad3
--cleaned up and fixed by MLD
function c511005013.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_DECK)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c511005013.spcon)
	c:RegisterEffect(e1)
	aux.CallToken(420)
end
function c511005013.filter(c)
	return c:IsFaceup() and c:IsHunder()
end
function c511005013.spcon(e,c)
	if not c then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511005013.filter,tp,LOCATION_MZONE,0,4,nil)
end
