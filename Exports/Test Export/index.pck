GDPC                �                                                                         T   res://.godot/exported/133200997/export-0cd3392bc9df5ef87a3b9b97265195af-console.scn p      l      ē}dU)G�[�Ö��    d   res://.godot/exported/133200997/export-7c82c4054c9a3ee575ae1f1946577c28-indestructible_lizard.scn   P      �      v�rO!���3�����[    X   res://.godot/exported/133200997/export-bb42e930e2b9f4e8e011cdb4d24b0ac0-module_base.scn �+      A      �h�Y��O]�0,����6    ,   res://.godot/global_script_class_cache.cfg  @0             ��Р�8���8~$}P�    H   res://.godot/imported/console.glb-658210670e84b59554fee5d96e3b28bf.scn          �      Px�{ZQ[G�Y=7    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�      �      �̛�*$q�*�́        res://.godot/uid_cache.bin   4      �       ��X�v����`��J%    $   res://Assets/3D/console.glb.import  �      �       �2j%d��E+�3z    0   res://Modules/indestructible_lizard.tscn.remap  �.      r       9����U�\�4�}�       res://console.gd�	      r      ��vl�l�����א��4       res://console.tscn.remap`/      d       �Ǎ�9���P�2W       res://icon.svg  `0      �      C��=U���^Qu��U3       res://icon.svg.import   �*      �       }؈����U��5       res://module_base.tscn.remap�/      h       R��u���g57S�h       res://project.binary�4      Q      �dM.�xfBwT��hj�                RSCC      �  �  �   (�/�` �/ 6��=@o�I?�0<F���G����ֈ�D{o�AI����|o����{ ֧�	�g�~����S� � � /Z�L5G;����ӧ効��-�6��?�c^�f�j��L��=p6
R5RQ�㖥;j��6�lI��FA�޴����yr�	�K��$�1�j����wz�-���\�uJ �׫%��R����'��y�����4%�������;�1��V�@@Cɑ�%���G�B.�w��6#5�)wd페��i�����9�Zr�UY��J�xِFQ�W�`N��"�|�/�#`�|�6�mO�ӎ��"Iˉ��h���u��Ǻn7jZ��Ŝ.�6ƝtA��$���s)AK������l���<bqZ+-)*�N2sxq�����p�rY;A0N�EX��sԳ����d��u���P�S��R�.C�\n����S�K^M9W\�2Z��i9�al���,�nTS�F�zS��cT��|Ok�@	��mS�*��
���F���r���o9��8]6�ܭ1����ɶ4TI&�=e��v���'�{�M3�É�"�G՟,�|� � �?��?*U�"m�Y�0RU),<��`�aFJ�R�@`Q�ei{�= g�|����+�l��s����h(%bh�`Hh�Q�B�
-Lp�T��⯪����J���<;�j�თTxG ���5�+�d��d-I���	%"���I�z���B42#I

Rhq�`�A�`d9ɒ
!4##2AIARFJ���l��m�oVa˦4�M{S/C�LL�f~�(�蓼�Tj!�k'�>��C˳�������:DVX����C������� �sS��M�A��-��H��Ei=O������+֭e�b��>��^s�����6k7�����jW�Y��	�IJ*��&|�2ԍ2��AA__�~&-�bd�������ƈ0p ;6�b��a��H���!���17��Q	Rɯ)�ä����ż���2F����^t��rk�Kұ���6��J�!�����l�鲖G���+	B�>�o1+�6?��%�?�J:x �,%�L�(�<���U7�^���w��NC�l!.�2bH�I�Q������y�X �Pޕ9����%_�%r�K�Ɖ/�ѼkwQk�O�����<���+�n�1t��.z@:�$?E]���|�Sz�NPf9b��p��PW�:�T+���d�R�X��9����nF���e#�Ǜ�&4$���ш�H=]w�%t�9��H&��ު"0dh%���pL�@��4<k�5�km�?�����_N�ߕ�����b�Bߞ��֙�F�<& ��:�rm2�eL�ipc��zj�ni��@�b��#*���u����`�}��bO����sS��x�K���n��t���l�K08�!�I����I�8�ud�����C��~��Nl��ؖ�����v�@o
�����Mr1_��(0�|_�ՙ��\S���cU��<�䀫��= (�/� �� �� �'�������h����w��M����l��g���o)	E��7=���KE�U��j��p�ǖ+bd!�N{�/$� ~�k�� K���7J2I9���	xJi=j@�U��W���iкXRSCC  [remap]

importer="scene"
importer_version=1
type="PackedScene"
uid="uid://cbi150y2l3nkj"
path="res://.godot/imported/console.glb-658210670e84b59554fee5d96e3b28bf.scn"
        RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://module_base.tscn p��/�Jh      local://PackedScene_owkas          PackedScene          	         names "         Indestructible Lizard    Node3D    ModuleBase    	   variants                       node_count             nodes        ��������       ����                ���                     conn_count              conns               node_paths              editable_instances              version             RSRC  extends Node3D

const CLICK_RAY_LENGTH = 10

var MODULES = [[null, null, null, null], [null, null, null, null]]
const BASE_MODULE_POSITION = Vector2(-0.75, 1.75)
const DELTA_MODULE_POSITION = Vector2(0.5, -0.5)

@onready var module_wrapper = $ModuleWrapper
@onready var camera = $Camera3D

#Module Types
const INDESTRUCTIBLE_LIZARD_MODULE = preload("res://Modules/indestructible_lizard.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * CLICK_RAY_LENGTH
		
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		
		if result:
			match result.collider.collision_layer:
				1:
					result.collider.interact
				_:
					printerr("Bad collision layer " + str(result.collider.collision_layer) + " on collider " + result.collider.name)

func _ready():
	spawn_module(Vector2i(2, 0), INDESTRUCTIBLE_LIZARD_MODULE)

func spawn_module(location: Vector2i, module: PackedScene) -> void:
	if location.y >= MODULES.size() or location.x >= MODULES[location.y].size():
		printerr("Bad location " + str(location.x) + ", " + str(location.y))
		return
	
	var new_module = module.instantiate()
	module_wrapper.add_child(new_module)
	new_module.position = Vector3(BASE_MODULE_POSITION.x + DELTA_MODULE_POSITION.x * location.x, BASE_MODULE_POSITION.y + DELTA_MODULE_POSITION.y * location.y, -0.5)
              RSRC                    PackedScene            ��������                                            b      resource_local_to_scene    resource_name    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction    script 	   _bundled       Script    res://console.gd ��������   PackedScene    res://Assets/3D/console.glb ����\`vC      local://Environment_be4lp �	         local://PackedScene_1vkat �	         Environment                   ��>��>��>  �?`         PackedScene    a      	         names "         Console    script    Node3D    console    ModuleWrapper 	   Camera3D 
   transform    current    fov    size    WorldEnvironment    environment    DirectionalLight3D    light_color    shadow_enabled    	   variants    	                           �?              �?              �?    �z�?�p=@         �̼A   �v@             �5?    �5�   ?�5?   ?   ?�5�   ?               ��K?��U?��Y?  �?      node_count             nodes     <   ��������       ����                      ���                            ����                      ����                     	                  
   
   ����                          ����                               conn_count              conns               node_paths              editable_instances              version       `      RSRC    GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://buanx6sv075cf"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    size    subdivide_width    subdivide_height    subdivide_depth    script 	   _bundled           local://BoxMesh_smv14 �         local://PackedScene_sxo17 �         BoxMesh          ���>���>��L=         PackedScene          	         names "         ModuleBase    mesh    MeshInstance3D    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC               [remap]

path="res://.godot/exported/133200997/export-7c82c4054c9a3ee575ae1f1946577c28-indestructible_lizard.scn"
              [remap]

path="res://.godot/exported/133200997/export-0cd3392bc9df5ef87a3b9b97265195af-console.scn"
            [remap]

path="res://.godot/exported/133200997/export-bb42e930e2b9f4e8e011cdb4d24b0ac0-module_base.scn"
        list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             頣SC�[   res://console.tscn�K�Wq�4   res://icon.svg����\`vC   res://Assets/3D/console.glbp��/�Jh   res://module_base.tscn0���&\5 (   res://Modules/indestructible_lizard.tscn       ECFG      application/config/name0      '   ACF - Aberration Containment Foundation    application/run/main_scene         res://console.tscn     application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     layer_names/3d_physics/layer_1         Module Component               