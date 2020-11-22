importXcosDiagram(Programm.Modules.InputSignals.Path + signalType.String(signalType.Value) + ".zcos");
Programm.Diagrams.InputSignal = scs_m;

importXcosDiagram(Programm.Modules.Objects.Path + link_type.String(link_type.Value) + ".zcos");
Programm.Diagrams.Object = scs_m;

importXcosDiagram(Programm.Modules.Indetification.Path + uiFilterOrder.String(uiFilterOrder.Value) + ".zcos");
Programm.Diagrams.Identification = scs_m;

importXcosDiagram(programmPath + "MainXcos.zcos");
Programm.Diagrams.Main = scs_m;
