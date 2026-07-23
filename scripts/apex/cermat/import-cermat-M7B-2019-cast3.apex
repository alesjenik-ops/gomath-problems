String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD19C0T02';
Integer YEAR = 2019;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M7B 2019 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží přímka $BC$ a mimo ni bod $M$ (viz obrázek).','Úsečka $BC$ je rameno rovnoramenného trojúhelníku $ABC$. Bod $M$ leží na ose souměrnosti tohoto trojúhelníku.','8.1 Sestrojte a označte písmenem osu souměrnosti $o$ trojúhelníku $ABC$.','8.2 Sestrojte a označte písmenem chybějící vrchol $A$ trojúhelníku $ABC$ a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"> <line x1="300" y1="30" x2="300" y2="270" stroke="#000" stroke-width="2"/> <line x1="292" y1="70" x2="308" y2="70" stroke="#000" stroke-width="2"/> <text x="315" y="75" font-size="16" font-style="italic">C</text> <line x1="292" y1="238" x2="308" y2="238" stroke="#000" stroke-width="2"/> <text x="315" y="243" font-size="16" font-style="italic">B</text> <text x="150" y="153" font-size="15" text-anchor="middle">x</text> <text x="163" y="158" font-size="16" font-style="italic">M</text> </svg>',
  'primka-bc-m.svg',
  'Svislá přímka s vyznačenými body B (dole) a C (nahoře) a bod M vlevo od přímky.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Protože $BC$ je rameno, je hlavním vrcholem (vrcholem u základny naproti) buď $B$, nebo $C$; osa souměrnosti prochází hlavním vrcholem a bodem $M$. Vrchol $A$ je obrazem druhého krajního bodu úsečky $BC$ v osové souměrnosti podle této osy.','Řešení 1: osa $o_1$ je přímka $BM$, vrchol $A_1$ je obrazem bodu $C$ podle $o_1$.','Řešení 2: osa $o_2$ je přímka $CM$, vrchol $A_2$ je obrazem bodu $B$ podle $o_2$.'},
  'Dvě řešení: osa $o_1=BM$ a $A_1$ jako obraz $C$; osa $o_2=CM$ a $A_2$ jako obraz $B$ (vrcholy $A_1$, $A_2$ – viz obrázek v klíči).',
  3, 7, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Strana $AB$ leží na přímce $p$, bod $S$ leží uvnitř některé ze tří zbývajících stran obdélníku $ABCD$. Jeden krajní bod strany, která obsahuje bod $S$, leží na kružnici $k$.','Sestrojte a označte písmeny chybějící vrcholy $B$, $C$, $D$ obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 340" font-family="sans-serif"> <circle cx="280" cy="155" r="120" fill="none" stroke="#000" stroke-width="2"/> <text x="182" y="120" font-size="16" font-style="italic">k</text> <text x="276" y="160" font-size="15" text-anchor="middle">x</text> <text x="288" y="170" font-size="16" font-style="italic">S</text> <line x1="40" y1="205" x2="440" y2="295" stroke="#000" stroke-width="2"/> <text x="425" y="290" font-size="16" font-style="italic">p</text> <text x="176" y="252" font-size="16" font-style="italic">A</text> </svg>',
  'primka-kruznice-a.svg',
  'Kružnice k se středem S a přímka p, která kružnici protíná; bod A je dolní průsečík.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Strana $AB$ leží na přímce $p$, strany $AD$ a $BC$ jsou k $p$ kolmé. Bod $S$ leží uvnitř jedné ze stran $BC$, $CD$, $DA$ a jeden krajní bod této strany leží na kružnici $k$; z těchto podmínek se dopočtou vrcholy $B$, $C$, $D$. Úloha má dvě řešení.'},
  'Dvě řešení – obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$ (strana $AB$ na přímce $p$, vrcholy $B$, $C$, $D$ – viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
