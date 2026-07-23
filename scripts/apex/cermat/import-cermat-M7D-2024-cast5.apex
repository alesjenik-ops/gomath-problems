String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M7D 2024 – úloha 13',
  new List<String>{'Jsou dány rovnoběžky $a$ a $b$ a přímky $c$, $d$ a $e$, které se protínají s přímkou $b$ v bodě $B$ (viz obrázek).','Jaký je součet velikostí úhlů $\\alpha$ a $\\beta$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'},
  new List<String>{'A) $74^\\circ$','B) $73^\\circ$','C) $72^\\circ$','D) $71^\\circ$','E) $70^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 300" font-family="sans-serif"> <line x1="40" y1="95" x2="430" y2="95" stroke="#000" stroke-width="1.5"/> <text x="440" y="99" font-size="15" font-style="italic">b</text> <line x1="40" y1="235" x2="452" y2="235" stroke="#000" stroke-width="1.5"/> <text x="460" y="239" font-size="15" font-style="italic">a</text> <line x1="120" y1="235" x2="300" y2="40" stroke="#000"/> <line x1="230" y1="235" x2="270" y2="40" stroke="#000"/> <line x1="360" y1="235" x2="210" y2="40" stroke="#000"/> <text x="256" y="90" font-size="13" font-style="italic">B</text> <text x="214" y="46" font-size="14" font-style="italic">e</text> <text x="262" y="46" font-size="14" font-style="italic">d</text> <text x="300" y="52" font-size="14" font-style="italic">c</text> <text x="243" y="80" font-size="13">a</text> <text x="252" y="122" font-size="13">b</text> <text x="128" y="226" font-size="12">38</text> <text x="226" y="258" font-size="12">75</text> <text x="330" y="226" font-size="12">110</text> </svg>',
  'uhly-rovnobezky.svg',
  'Rovnoběžky a a b a tři přímky c, d, e procházející bodem B; u přímky a jsou vyznačeny úhly 38, 75 a 110 stupňů, u bodu B úhly alfa a beta.',
  'Schematický nákres k úloze 13 (ilustrační)',
  new List<String>{'Protože $a\\parallel b$, svírají přímky $c$, $d$, $e$ s oběma rovnoběžkami stejné úhly (souhlasné, resp. střídavé úhly).','Úhel $\\alpha$ je mezi přímkami $c$ a $d$ a úhel $\\beta$ mezi přímkami $d$ a $e$, takže $\\alpha+\\beta$ je úhel mezi přímkami $c$ a $e$. Ten dopočteme z úhlů u přímky $a$: $\\alpha+\\beta=110^\\circ-38^\\circ=72^\\circ$.'},
  'C) $72^\\circ$',
  2, 5, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 14',
  new List<String>{'Číselná osa je rozdělena na shodné dílky. Písmena $A$, $B$, $C$ a $D$ představují celá čísla. Víme, že $A+B=8$ a $A+C=4$ (viz obrázek).','Jaký je součet čísel $D$ a $C$?'},
  new List<String>{'A) $24$','B) $12$','C) $-12$','D) $-16$','E) $-24$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 130" font-family="sans-serif"><line x1="24" y1="60" x2="416" y2="60" stroke="#000" stroke-width="1.5"/><polygon points="416,60 406,56 406,64" fill="#000"/><polygon points="24,60 34,56 34,64" fill="#000"/><line x1="60" y1="52" x2="60" y2="68" stroke="#000"/><line x1="104" y1="52" x2="104" y2="68" stroke="#000"/><line x1="148" y1="52" x2="148" y2="68" stroke="#000"/><line x1="192" y1="52" x2="192" y2="68" stroke="#000"/><line x1="236" y1="52" x2="236" y2="68" stroke="#000"/><line x1="280" y1="52" x2="280" y2="68" stroke="#000"/><line x1="324" y1="52" x2="324" y2="68" stroke="#000"/><line x1="368" y1="52" x2="368" y2="68" stroke="#000"/><text x="60" y="92" font-size="15" text-anchor="middle" font-style="italic">D</text><text x="236" y="92" font-size="15" text-anchor="middle" font-style="italic">C</text><text x="280" y="92" font-size="15" text-anchor="middle" font-style="italic">B</text><text x="368" y="92" font-size="15" text-anchor="middle" font-style="italic">A</text></svg>',
  'ciselna-osa.svg',
  'Číselná osa rozdělená na shodné dílky s vyznačenými body D, C, B, A (zleva doprava).',
  'Číselná osa (schematický nákres)',
  new List<String>{'Z rovností $A+B=8$ a $A+C=4$ plyne $B-C=4$. Body $B$ a $C$ jsou na ose vzdáleny jeden dílek, jeden dílek tedy odpovídá hodnotě $4$.','Z osy pak $A=8$, $B=0$, $C=-4$ a $D=-20$. Součet $D+C=-20+(-4)=-24$.'},
  'E) $-24$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
