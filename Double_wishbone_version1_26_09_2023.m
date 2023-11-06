%Double wishbone version 1.0  26.09.2023
close;clear all;clc;

m=300; %mass [kg]
Wheelbase=2; %[m]
COGx=1.25; %[m] distance from front to COG
g=9.81;
c=500; %damper constant [N/(m/s)]
k=10000; %spring stiffnes [N/m]
a=0.6; %[m] distance hinge point to centre wheel
b=0.8; %[m] distance hinge point to end of spring
niu=30; %[degrees] angle between vertical and spring
alpha=5; %[degrees] angle between upper wishbone and horizontal
beta=2; %[degrees] angle between lower wishbone and horizontal
gamma=30; %[degrees] angle between spring/damper and horizontal
Ro=1.24; %[kg/m^3] air density;
car_speed=19.4; %[m/s]
wing_width=1.2; %[m]
Wing_height=0.7; %[m]
angle_wing=20; %[degrees]
lift_coeff=0.98;

area=((7/1000)^2)*pi-((3.15/1000)^2)*pi; %wishbone link section area in [m^2]


theta1=20; %[degrees] half of the angle between linkage of the lower wishbone
theta2=22; %[degrees] half of the angle between linkage of the upper wishbone

Force_rear_axle=0.5*wing_width*Wing_height*sin(angle_wing)*lift_coeff*Ro*car_speed+m*g-(0.5*wing_width*Wing_height*sin(angle_wing)*lift_coeff*Ro*car_speed+m*g*(Wheelbase-COGx))/Wheelbase;
Force_rear_tyre=Force_rear_axle/2;

sim("Suspension2_26_09_2023");

subplot(2,2,1);
plot(tout,disp_wheel); % displacement of the wheel after going up a bump
grid minor
title('Displacement of the wheel (in meters) after hitting and going up a bump');

subplot(2,2,2);
plot(tout,disp_sus); % displacement of the wheel after going up a bump
grid minor
title('Displacement of the end-point of suspension (in meters) after hitting a bump');

%
%
%

subplot(2,2,3)
plot(tout,Force_lower_wishbone_link)
grid minor
title('Force lower wishbone link')
ylabel('Compressive (-) /Tensile force (+) [N]');

subplot(2,2,4)
plot(tout,Force_upper_wishbone_link)
grid minor
title('Force upper wishbone link')
ylabel('Compressive (-) /Tensile force (+) [N]');

figure ;
subplot(2,2,1)
plot(tout,Longitudinal_shear_force_lower_wishbone_link)
grid minor
title('Longitudinal shear force lower wishbone link')
ylabel('Shear force [N]');

subplot(2,2,2)
plot(tout,Longitudinal_shear_force_upper_wishbone_link)
grid minor
title('Longitudinal shear force upper wishbone link')
ylabel('Shear force [N]');


subplot(2,2,3)
plot(tout,Vertical_shear_force_lower_wishbone_link)
grid minor
title("Vertical shear force lower wishbone link")
ylabel('Shear force [N]');


subplot(2,2,4)
plot(tout,Vertical_shear_force_upper_wishbone_link)
grid minor
title("Vertical shear force upper wishbone link")
ylabel('Shear force [N]');

%
%
%
%

figure ('Name','Stress rear lower wishbone link');
subplot(2,2,1)
plot(Average_normal_stress_rear_lower_link,'r')
grid minor
title("Average normal stress rear lower link")
ylabel('Normal stress [Pa]');


min_Normal_stress_rear_lower_link=min(Average_normal_stress_rear_lower_link);
disp("min_Normal_stress_rear_lower_link [Pa]");
disp(min_Normal_stress_rear_lower_link);

max_Normal_stress_rear_lower_link=max(Average_normal_stress_rear_lower_link);
disp("max_Normal_stress_rear_lower_link [Pa]")
disp(max_Normal_stress_rear_lower_link);




subplot(2,2,2)
plot(Average_vertical_shear_stress_rear_lower_link,'r')
grid minor
title('Average vertical shear stress rear lower link')
ylabel('Shear stress [Pa]');

min_Average_vertical_shear_stress_rear_lower_link=min(Average_vertical_shear_stress_rear_lower_link);
disp("min_Average_vertical_shear_stress_rear_lower_link [Pa]");
disp(min_Average_vertical_shear_stress_rear_lower_link);

max_Average_vertical_shear_stress_rear_lower_link=max(Average_vertical_shear_stress_rear_lower_link);
disp("max_Average_vertical_shear_stress_rear_lower_link [Pa]");
disp(max_Average_vertical_shear_stress_rear_lower_link);


Max_vertical_shear_stress_rear_lower_link=0;
if(min_Average_vertical_shear_stress_rear_lower_link<0 && max_Average_vertical_shear_stress_rear_lower_link<0)
    Max_vertical_shear_stress_rear_lower_link=abs(min_Average_vertical_shear_stress_rear_lower_link);
else
    if(min_Average_vertical_shear_stress_rear_lower_link>0 && max_Average_vertical_shear_stress_rear_lower_link>0)
        Max_vertical_shear_stress_rear_lower_link=abs(max_Average_vertical_shear_stress_rear_lower_link);
    end
end

%disp(Max_vertical_shear_stress_rear_lower_link);






subplot(2,2,3)
plot(Average_longitudinal_shear_stress_rear_lower_link,'r')
grid minor
title('Average longitudinal shear stress rear lower link')
ylabel('Shear stress [Pa]');

min_Average_longitudinal_shear_stress_rear_lower_link=min(Average_longitudinal_shear_stress_rear_lower_link);
disp("min_Average_longitudinal_shear_stress_rear_lower_link");
disp(min_Average_longitudinal_shear_stress_rear_lower_link);

max_Average_longitudinal_shear_stress_rear_lower_link=max(Average_longitudinal_shear_stress_rear_lower_link);
disp("max_Average_longitudinal_shear_stress_rear_lower_link");
disp(max_Average_longitudinal_shear_stress_rear_lower_link);




Max_longitudinal_shear_stress_rear_lower_link=0;
if(min_Average_longitudinal_shear_stress_rear_lower_link<0 && max_Average_longitudinal_shear_stress_rear_lower_link<0)
    Max_longitudinal_shear_stress_rear_lower_link=abs(min_Average_longitudinal_shear_stress_rear_lower_link);
else
    if(min_Average_longitudinal_shear_stress_rear_lower_link<0 && max_Average_longitudinal_shear_stress_rear_lower_link<0)
        Max_longitudinal_shear_stress_rear_lower_link=abs(max_Average_longitudinal_shear_stress_rear_lower_link);
    end
end

%disp(Max_longitudinal_shear_stress_rear_lower_link);




%
%
%
%

figure ('Name','Stress rear upper wishbone link');
subplot(2,2,1)
plot(Average_normal_stress_rear_upper_link,'g')
grid minor
title("Average normal stress rear upper link")
ylabel('Normal stress [Pa]');

min_Normal_stress_rear_upper_link=min(Average_normal_stress_rear_upper_link);
disp("min_Normal_stress_rear_upper_link [Pa]");
disp(min_Normal_stress_rear_upper_link);

max_Normal_stress_rear_upper_link=max(Average_normal_stress_rear_upper_link);
disp("max_Normal_stress_rear_upper_link [Pa]");
disp(max_Normal_stress_rear_upper_link);




subplot(2,2,2)
plot(Average_vertical_shear_stress_upper_link,'g')
grid minor
title('Average vertical shear stress rear upper link')
ylabel('Shear stress [Pa]');

min_Average_vertical_shear_stress_rear_upper_link=min(Average_vertical_shear_stress_upper_link);
disp("min_Average_vertical_shear_stress_rear_upper_link [Pa]");
disp(min_Average_vertical_shear_stress_rear_upper_link);
max_Average_vertical_shear_stress_rear_upper_link=min(Average_vertical_shear_stress_upper_link);
disp("max_Average_vertical_shear_stress_rear_upper_link [Pa]");
disp(max_Average_vertical_shear_stress_rear_upper_link);




Max_vertical_shear_stress_rear_upper_link=0;
if(min_Average_vertical_shear_stress_rear_upper_link<0 && max_Average_vertical_shear_stress_rear_upper_link<0)
    Max_vertical_shear_stress_rear_upper_link=abs(min_Average_vertical_shear_stress_rear_upper_link);
else
    if(min_Average_vertical_shear_stress_rear_upper_link<0 && max_Average_vertical_shear_stress_rear_upper_link<0)
        Max_vertical_shear_stress_rear_upper_link=abs(max_Average_vertical_shear_stress_rear_upper_link);
    end
end

%disp(Max_vertical_shear_stress_rear_upper_link);






subplot(2,2,3)
plot(Average_longitudinal_shear_stress_rear_upper_link,'g')
grid minor
title('Average longitudinal shear stress rear upper link')
ylabel('Shear stress [Pa]');

min_Average_longitudinal_shear_stress_rear_upper_link=min(Average_longitudinal_shear_stress_rear_upper_link);
disp("min_Average_longitudinal_shear_stress_rear_upper_link");
disp(min_Average_longitudinal_shear_stress_rear_upper_link);

max_Average_longitudinal_shear_stress_rear_upper_link=max(Average_longitudinal_shear_stress_rear_upper_link);
disp("max_Average_longitudinal_shear_stress_rear_upper_link");
disp(max_Average_longitudinal_shear_stress_rear_upper_link);




Max_longitudinal_shear_stress_rear_upper_link=0;
if(min_Average_vertical_shear_stress_rear_upper_link<0 && max_Average_vertical_shear_stress_rear_upper_link<0)
    Max_longitudinal_shear_stress_rear_upper_link=abs(min_Average_vertical_shear_stress_rear_upper_link);
else
    if(min_Average_vertical_shear_stress_rear_upper_link<0 && max_Average_vertical_shear_stress_rear_upper_link<0)
        Max_longitudinal_shear_stress_rear_upper_link=abs(max_Average_vertical_shear_stress_rear_upper_link);
    end
end

%disp(Max_longitudinal_shear_stress_rear_upper_link);








%Calculate the critical load the links can take before buckling
E_1020_cold_rolled=205*10^9; % Modulus of elasticity [Pa]
Polar_moment=0.000000003617; % Polar moment wishbone link [m^4]
Length_links=404.5/1000; % lenght of the link [m]
P_max=pi^2*E_1020_cold_rolled*Polar_moment/Length_links^2;

if(P_max>abs(min_Normal_stress_rear_lower_link*area*(-1)))
    disp("Lower rear wishbones link will not buckle");
else
    disp("Problem buckle, lower rear wishbone");
end

%Calculate the critical load the links can take before plastic deforamtion
Yield_1020_cold_rolled=350*10^6; %Yield strength [Pa]
if(Yield_1020_cold_rolled>max_Normal_stress_rear_upper_link)
    disp("Upper rear wishbone link will not plasticly deform")
else
    disp("Problem yield, upper rear wishbone");
end

Shear_modulus_1020_cold_rolled=80*10^9;
c=12.7/1000/2; %distance to centre of tube [m]
Max_Shear_stress_rear_low_link=sqrt(Max_longitudinal_shear_stress_rear_lower_link^2+Max_vertical_shear_stress_rear_lower_link^2);
Max_Shear_stress_rear_upper_link=sqrt(Max_longitudinal_shear_stress_rear_upper_link^2+Max_vertical_shear_stress_rear_upper_link^2);
disp(Max_Shear_stress_rear_low_link);
disp(Max_Shear_stress_rear_upper_link);


if(Max_Shear_stress_rear_low_link>=Shear_modulus_1020_cold_rolled)
    disp("shear failure rear low link");
else
    disp("rear low link will not break");
end

if(Max_Shear_stress_rear_upper_link>=Shear_modulus_1020_cold_rolled)
    disp("shear failure rear upper link");
else
    disp("rear upper link will not break");
end












