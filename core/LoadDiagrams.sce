importXcosDiagram(IdentificationACS.Modules.InputSignals.Path + signalType.String(signalType.Value) + ".zcos");
IdentificationACS.Diagrams.InputSignal = scs_m;

importXcosDiagram(IdentificationACS.Modules.Objects.Path + link_type.String(link_type.Value) + ".zcos");
IdentificationACS.Diagrams.Object = scs_m;

importXcosDiagram(IdentificationACS.Modules.Indetification.Path + uiFilterOrder.String(uiFilterOrder.Value) + ".zcos");
IdentificationACS.Diagrams.Identification = scs_m;

importXcosDiagram(programmPath + "MainXcos.zcos");
IdentificationACS.Diagrams.Main = scs_m;
