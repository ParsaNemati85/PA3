% parsa khodabandehlou
% sat feb 7 2026
% pkhodab@ncsu.edu
% 
% Crewmate.m
% Implementation
classdef Crewmate

    properties (Access = public)
        color = "red"
        sus = false;
    end

    methods(Access = public)

        function obj = Crewmate(color)
            obj.color = color;
        end
    end

end