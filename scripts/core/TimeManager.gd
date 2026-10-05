[gd_scene load_steps=16 format=3]

[ext_resource type="Script" path="res://scripts/core/World.gd" id="1_4m5n3"]
[ext_resource type="Script" path="res://scripts/player/Player.gd" id="2_5l8j6"]
[ext_resource type="Script" path="res://scripts/npc/NPC.gd" id="3_7w3k1"]
[ext_resource type="Script" path="res://scripts/core/TimeManager.gd" id="4_9j2p1"]
[ext_resource type="PackedScene" path="res://scenes/ui/HUD.tscn" id="5_d4q2k"]

[sub_resource type="BoxMesh" id="BoxMesh_m6j0x"]
size = Vector3(80, 1, 80)

[sub_resource type="BoxShape3D" id="BoxShape3D_ground"]
size = Vector3(80, 1, 80)

[sub_resource type="CapsuleShape3D" id="CapsuleShape3D_oh8we"]
radius = 0.45
height = 1.8

[sub_resource type="BoxMesh" id="BoxMesh_4hb0h"]
size = Vector3(0.55, 1.2, 0.35)

[sub_resource type="SphereMesh" id="SphereMesh_4d2mg"]
radius = 0.3
height = 0.6

[sub_resource type="BoxMesh" id="BoxMesh_3u8rj"]
size = Vector3(0.8, 0.9, 0.5)

[sub_resource type="SphereMesh" id="SphereMesh_tqk7r"]
radius = 0.28
height = 0.56

[sub_resource type="Environment" id="Environment_1"]
background_mode = 1
background_color = Color(0.06, 0.09, 0.12, 1)
ambient_light_source = 2
ambient_light_color = Color(0.8, 0.8, 0.9, 1)
ambient_light_energy = 0.8

[sub_resource type="WorldEnvironment" id="WorldEnvironment_1"]
environment = SubResource("Environment_1")

[node name="Main" type="Node3D"]
script = ExtResource("1_4m5n3")

[node name="WorldEnvironment" type="WorldEnvironment" parent="."]
environment = SubResource("Environment_1")

[node name="Sun" type="DirectionalLight3D" parent="."]
transform = Transform3D(0.75, -0.545, 0.379, 0, 0.569, 0.822, -0.661, -0.616, 0.427, 0, 8, 0)
light_energy = 1.4
shadow_enabled = true

[node name="TimeManager" type="Node" parent="."]
script = ExtResource("4_9j2p1")

[node name="Ground" type="StaticBody3D" parent="."]

[node name="MeshInstance3D" type="MeshInstance3D" parent="Ground"]
mesh = SubResource("BoxMesh_m6j0x")

[node name="CollisionShape3D" type="CollisionShape3D" parent="Ground"]
shape = SubResource("BoxShape3D_ground")

[node name="Player" type="CharacterBody3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.2, 0)
script = ExtResource("2_5l8j6")

[node name="CollisionShape3D" type="CollisionShape3D" parent="Player"]
shape = SubResource("CapsuleShape3D_oh8we")

[node name="Visuals" type="Node3D" parent="Player"]

[node name="Torso" type="MeshInstance3D" parent="Player/Visuals"]
mesh = SubResource("BoxMesh_4hb0h")

[node name="Head" type="MeshInstance3D" parent="Player/Visuals"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.05, 0)
mesh = SubResource("SphereMesh_4d2mg")

[node name="LeftLeg" type="MeshInstance3D" parent="Player/Visuals"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -0.15, -0.73, 0)
mesh = SubResource("BoxMesh_4hb0h")

[node name="RightLeg" type="MeshInstance3D" parent="Player/Visuals"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0.15, -0.73, 0)
mesh = SubResource("BoxMesh_4hb0h")

[node name="CameraPivot" type="Node3D" parent="Player"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.4, 0)

[node name="Camera3D" type="Camera3D" parent="Player/CameraPivot"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.5, -5.5)
current = true
fov = 70.0

[node name="Guide" type="CharacterBody3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 7, 1.1, 2)
script = ExtResource("3_7w3k1")
npc_name = "The Guide"
profession = "Mentor"
work_position = Vector3(7, 0, 2)

[node name="CollisionShape3D" type="CollisionShape3D" parent="Guide"]
shape = SubResource("CapsuleShape3D_oh8we")

[node name="Visuals" type="Node3D" parent="Guide"]

[node name="Torso" type="MeshInstance3D" parent="Guide/Visuals"]
mesh = SubResource("BoxMesh_3u8rj")

[node name="Head" type="MeshInstance3D" parent="Guide/Visuals"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.8, 0)
mesh = SubResource("SphereMesh_tqk7r")

[node name="MarketVendor" type="CharacterBody3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -7, 1.1, -3)
script = ExtResource("3_7w3k1")
npc_name = "Amina"
profession = "Market Vendor"
work_position = Vector3(-7, 0, -3)

[node name="CollisionShape3D" type="CollisionShape3D" parent="MarketVendor"]
shape = SubResource("CapsuleShape3D_oh8we")

[node name="Visuals" type="Node3D" parent="MarketVendor"]

[node name="Torso" type="MeshInstance3D" parent="MarketVendor/Visuals"]
mesh = SubResource("BoxMesh_3u8rj")

[node name="Head" type="MeshInstance3D" parent="MarketVendor/Visuals"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.8, 0)
mesh = SubResource("SphereMesh_tqk7r")

[node name="HUD" parent="." type="CanvasLayer" instance=ExtResource("5_d4q2k")]
