
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D paletteTex;
uniform vec4 paletteUVs;

void main()
{
	// Get current pixel color, discard alpha channel
	vec4 cola = texture2D(gm_BaseTexture, v_vTexcoord);
	
	if (cola.a > 0.) {
		
		vec3 col = cola.rgb;
	
		// mindis keeps track of the smallest distance between current pixel color and any color from the palette
		float mindis = 999.;
	
		// closest should contain the color from the palette that is closest to current pixel color, after for loop. Initiates at a placeholder value of blue, for debugging
		vec3 closest = vec3(0.2, 0., 0.7);
	
		// find size of each pixel, the palette sprite is 16x1
		vec2 pixelSize = vec2((paletteUVs[2] - paletteUVs[0]) / 16., (paletteUVs[3] - paletteUVs[1]));
	
	
		// loop through each pixel of palette texture
		for (int i = 0; i < 16; i++) {
		
			// Get i color of palette tetxure
			vec3 curcol = texture2D(paletteTex, vec2(paletteUVs[0] + float(i) * pixelSize.x + pixelSize.x * .5, paletteUVs[1] + pixelSize.y * .5)).rgb;
		
			// calculate difference between current pallete color and current pixel color
			float curdis = distance(col, curcol);
		
			// Compare, if closer, remember
			if (curdis < mindis) {
				mindis = curdis;
				closest = curcol;
			}
		}
	
	    gl_FragColor = vec4(closest, 1.);
	} else {
		gl_FragColor = vec4(0., 0., 0., 0.);	
	}
}

