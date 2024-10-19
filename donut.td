math := import("math")
strings := import("strings")

draw := fn(A, B) {
	b := []
	z := []
	
	cA := math.cos(A)
    sA := math.sin(A)
    cB := math.cos(B)
    sB := math.sin(B)
	
	for k := 0; k < 1760; k++ {
		if k % 80 == 79 {
			b = append(b, "\n")
		} 
		else { 
			b = append(b, " ")
		}
		z = append(z, 0)
	}
	
	j := 0
	
	for  j < 6.28 {
		// j <=> theta
		ct := math.cos(j)
		st := math.sin(j)
		i := 0; 
		for i < 6.28 {
			// i <=> phi
			sp := math.sin(i)
			cp := math.cos(i)
			h := ct + 2 // R1 + R2*cos(theta)
			D := 1 / (sp * h * sA + st * cA + 5) // this is 1/z
			t := sp * h * cA - st * sA // this is a clever factoring of some of the terms in x' and y'
			// println(cp, sp)
			// println(cp, sp)
			
			x := int(40 + 30 * D * (cp * h * cB - t * sB))
			y := int(12 + 15 * D * (cp * h * sB + t * cB))
			o := int(x + 80 * y)
			N := int( 8 * ( (st * sA - sp * ct * cA) * cB - sp * ct * sA - st * cA - cp * ct * sB ) )
			// println(x)
			// println(y)
			// println(D)
			// println(z[o])
			if (y < 22 && y >= 0 && x >= 0 && x < 79 && D > z[o]) {
				z[o] = D
				if N > 0 {
					b[o] = ".,_-~:=!*#$@"[N]
				}
				else {
					b[o] = "."
				}
			}
			i = i + 0.02
		}
		j = j + 0.07
	}
	println(strings.join(b, ""))
}

A := 1
B := 1

for {
	A = A + 0.07
	B = B + 0.03
	draw(A, B)
}