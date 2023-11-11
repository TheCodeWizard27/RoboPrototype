
extends Node

static func cubic_f(start: float, p1: Vector2, p2: Vector2, end: float, t: float) -> float:
	return cubic(Vector2(start, 0), p1, p2, Vector2(end, 0), t).x

static func cubic(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2:
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)
	
	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)
	
	return r0.lerp(r1, t)
