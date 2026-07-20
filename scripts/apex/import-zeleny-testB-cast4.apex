String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený B12 – objem osmibokého hranolu',
  new List<String>{'Na obrázku je podstava kolmého osmibokého hranolu, jehož výška je $50$ cm. Rozměry podstavy jsou $a=5$ cm, $b=2$ cm, $c=8$ cm.','Vypočtěte objem hranolu v cm³.'},
  new List<String>{'A) $1\\,200$ cm³','B) $1\\,600$ cm³','C) $2\\,800$ cm³','D) $3\\,400$ cm³','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 510" font-family="sans-serif"> <polygon points="170,80 250,80 370,240 370,320 250,480 170,480 50,320 50,240" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="50" y1="45" x2="370" y2="45" stroke="#000" stroke-width="1"/> <polygon points="50,45 60,41 60,49" fill="#000"/><polygon points="370,45 360,41 360,49" fill="#000"/> <text x="210" y="38" font-size="16" text-anchor="middle" font-style="italic">c</text> <text x="210" y="72" font-size="16" text-anchor="middle" font-style="italic">b</text> <text x="105" y="150" font-size="16" font-style="italic">a</text> <text x="308" y="150" font-size="16" font-style="italic">a</text> <text x="34" y="285" font-size="16" font-style="italic">b</text> <text x="378" y="285" font-size="16" font-style="italic">b</text> <text x="105" y="415" font-size="16" font-style="italic">a</text> <text x="308" y="415" font-size="16" font-style="italic">a</text> <text x="210" y="500" font-size="16" text-anchor="middle" font-style="italic">b</text> </svg>',
  'osmiuhelnik.svg',
  'Osmiúhelníková podstava hranolu, obdélník se seříznutými rohy, rozměry a rovná se 5, b rovná se 2, c rovná se 8.',
  'Podstava osmibokého hranolu',
  new List<String>{'Podstava je obdélník $c\\times v$ bez čtyř rohových trojúhelníků. Rameno $a=5$ cm má vodorovný průmět $\\frac{c-b}{2}=3$ cm a svislý $\\sqrt{5^2-3^2}=4$ cm. Výška obdélníku $v=4+2+4=10$ cm. Obsah podstavy $S=8\\cdot 10-4\\cdot\\frac{3\\cdot 4}{2}=80-24=56$ cm². Objem $V=56\\cdot 50=2\\,800$ cm³.'},
  'C) $2\\,800$ cm³',
  2, 6, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B13 – velikost úhlu v trojúhelníku',
  new List<String>{'Na obrázku je trojúhelník s vodorovnou čárkovanou přímkou a vyznačenými úhly.','Jak velký je úhel na obrázku označený symbolem „?"?'},
  new List<String>{'A) $41^\\circ$','B) $52^\\circ$','C) $62^\\circ$','D) $65^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 490" font-family="sans-serif"> <circle cx="246" cy="290" r="190" fill="none" stroke="#999" stroke-width="1" stroke-dasharray="4 5"/> <line x1="30" y1="250" x2="448" y2="250" stroke="#333" stroke-width="1.2" stroke-dasharray="6 6"/> <polygon points="60,250 432,329 157,122" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="157" y1="122" x2="246" y2="290" stroke="#000" stroke-width="1" stroke-dasharray="3 4"/> <line x1="195" y1="209" x2="207" y2="203" stroke="#000" stroke-width="2"/> <line x1="199" y1="216" x2="211" y2="210" stroke="#000" stroke-width="2"/> <line x1="151" y1="277" x2="154" y2="263" stroke="#000" stroke-width="2"/> <line x1="144" y1="275" x2="147" y2="261" stroke="#000" stroke-width="2"/> <text x="92" y="244" font-size="19">?</text> <text x="128" y="279" font-size="16" font-weight="bold">12°</text> <text x="348" y="238" font-size="16" font-weight="bold">37°</text> </svg>',
  'uhel-trojuhelnik.svg',
  'Trojúhelník s vodorovnou čárkovanou přímkou; základna svírá s ní 12°, pravé rameno 37°, u levého vrcholu je hledaný úhel označený otazníkem, shodné úsečky a Thaletova kružnice.',
  'Schematický nákres k úloze 13',
  new List<String>{'Základna svírá s vodorovnou přímkou úhel $12^\\circ$, pravé rameno $37^\\circ$, takže vnitřní úhel při pravém vrcholu je $37^\\circ-12^\\circ=25^\\circ$. Shodné úsečky (těžnice k přeponě je rovna polovině přepony) a Thaletova kružnice ukazují, že úhel při horním vrcholu je pravý, tedy $90^\\circ$. Hledaný úhel $?=180^\\circ-90^\\circ-25^\\circ=65^\\circ$.'},
  'D) $65^\\circ$',
  2, 6, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
