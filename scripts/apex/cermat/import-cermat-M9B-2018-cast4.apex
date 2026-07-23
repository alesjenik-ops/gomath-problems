String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M9B 2018 – úloha 9.2',
  new List<String>{'Úsečka $AB$ je přepona $c$ pravoúhlého trojúhelníku $ABC$. Bod $M$ leží na kterékoli z jeho tří výšek $v_a$, $v_b$, $v_c$.','Sestrojte chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte. Najděte všechna řešení. (Neuvažujte o řešení, kdy bod $M$ leží vně trojúhelníku.)'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 260" font-family="sans-serif"> <line x1="40" y1="220" x2="400" y2="220" stroke="#000" stroke-width="2"/> <line x1="80" y1="210" x2="80" y2="230" stroke="#000" stroke-width="2"/> <line x1="360" y1="210" x2="360" y2="230" stroke="#000" stroke-width="2"/> <text x="220" y="152" font-size="16" text-anchor="middle">×</text> <text x="74" y="245" font-size="14" font-style="italic">A</text> <text x="356" y="245" font-size="14" font-style="italic">B</text> <text x="228" y="150" font-size="14" font-style="italic">M</text> </svg>',
  'prepona-bod-m.svg',
  'Úsečka AB (přepona) a bod M ležící mimo ni; úkolem je najít vrchol C pravoúhlého trojúhelníku ABC.',
  'Výchozí obrázek k úloze 9.2',
  new List<String>{'Protože úhel u vrcholu $C$ je pravý, leží $C$ na Thaletově kružnici nad průměrem $AB$. Bod $M$ leží na některé z výšek: výška $v_c$ prochází body $C$ a $M$ kolmo k $AB$, výšky $v_a$, $v_b$ splývají s odvěsnami a procházejí vrcholem $A$, resp. $B$. Příslušné přímky protnou Thaletovu kružnici ve vrcholech $C$; úloha má tři řešení $C_1$, $C_2$, $C_3$.'},
  'Vrchol $C$ leží na Thaletově kružnici nad průměrem $AB$; podle toho, na které výšce ($v_a$, $v_b$, $v_c$) leží bod $M$, vzniknou tři řešení $C_1$, $C_2$, $C_3$ (viz obrázek v klíči).',
  3, 8, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 10',
  new List<String>{'V rovině leží polopřímka $AX$ a přímka $o$ (viz obrázek).','Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$ s osou souměrnosti $o$. Vrchol $D$ leží na polopřímce $AX$. Strany $AB$ a $AD$ mají stejnou délku.','Sestrojte a popište chybějící vrcholy lichoběžníku $ABCD$ a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 410" font-family="sans-serif"> <line x1="320" y1="360" x2="120" y2="105" stroke="#000" stroke-width="2"/> <line x1="200" y1="187" x2="212" y2="173" stroke="#000" stroke-width="2"/> <line x1="400" y1="110" x2="452" y2="380" stroke="#000" stroke-width="2"/> <text x="322" y="378" font-size="14" font-style="italic">A</text> <text x="184" y="182" font-size="14" font-style="italic">X</text> <text x="458" y="392" font-size="14" font-style="italic">o</text> </svg>',
  'poloprimka-ax-o.svg',
  'Polopřímka AX vycházející z bodu A a samostatná přímka o.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Osa $o$ je osou souměrnosti lichoběžníku. Vrchol $B$ sestrojíme jako obraz vrcholu $A$ v osové souměrnosti podle osy $o$; tím je dána délka základny $|AB|$. Vrchol $D$ leží na polopřímce $AX$ ve vzdálenosti $|AD|=|AB|$ od bodu $A$ (kružnice se středem $A$ a poloměrem $|AB|$). Vrchol $C$ je obrazem vrcholu $D$ podle osy $o$. Základny $AB$ a $CD$ jsou kolmé k ose $o$ a ramena $AD=BC$.'},
  'Vrchol $B$ je obraz $A$ v osové souměrnosti podle osy $o$, vrchol $D$ leží na polopřímce $AX$ s $|AD|=|AB|$ a vrchol $C$ je obraz $D$ podle osy $o$; vznikne rovnoramenný lichoběžník $ABCD$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
