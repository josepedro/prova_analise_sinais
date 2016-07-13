function indice = obter_indice(vetor_temporal, valor_temporal)
	[indice indice] = min(abs(vetor_temporal - valor_temporal));