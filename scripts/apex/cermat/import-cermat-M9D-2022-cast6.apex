String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD22C0T04';
Integer YEAR = 2022;

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
  'CERMAT M9D 2022 – úloha 12',
  new List<String>{'Čtyřúhelník je rozdělen na dva tmavé rovnostranné trojúhelníky, jeden bílý čtyřúhelník a jeden bílý trojúhelník (viz obrázek). Jsou vyznačeny úhly $41^\\circ$ a $36^\\circ$.','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $105^\\circ$','B) $110^\\circ$','C) $115^\\circ$','D) $120^\\circ$','E) větší než $120^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 575 250" font-family="sans-serif"> <polygon points="40,220 320,40 552,32 430,220" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <polygon points="250,220 320,40 552,32 430,220" fill="#c9c9c9" stroke="#000"/> <line x1="320" y1="40" x2="430" y2="220" stroke="#000"/> <line x1="250" y1="220" x2="245" y2="70" stroke="#000"/> <line x1="247" y1="150" x2="320" y2="40" stroke="#000"/> <text x="82" y="212" font-size="15">41°</text> <text x="262" y="160" font-size="15">36°</text> <text x="250" y="100" font-size="16" font-style="italic">φ</text> </svg>',
  'ctyruhelnik-uhel.svg',
  'Čtyřúhelník rozdělený na dva tmavé rovnostranné trojúhelníky a bílý čtyřúhelník a trojúhelník; vyznačeny úhly 41°, 36° a hledaný úhel φ.',
  'Schematický nákres k úloze 12',
  new List<String>{'Tmavé trojúhelníky jsou rovnostranné (vnitřní úhly $60^\\circ$). Postupným dopočítáním úhlů (přímý úhel na spodní přímce, daný úhel $36^\\circ$ a úhly $60^\\circ$ rovnostranných trojúhelníků) vychází pro $\\varphi$ hodnota větší než $120^\\circ$ (přibližně $125^\\circ$).'},
  'E) větší než $120^\\circ$',
  2, 5, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2022 – úloha 13',
  new List<String>{'Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník, jehož dvě delší strany měří $17$ cm a $15$ cm. Výška hranolu je $5$ cm. Obě podstavy hranolu jsou tmavé, ostatní stěny bílé. Ze čtyř těchto hranolů je slepeno těleso (viz obrázek), které má dvě shodné stěny tmavé a zbývající čtyři stěny bílé.','Jaký obsah mají dohromady všechny bílé stěny slepeného tělesa?'},
  new List<String>{'A) menší než $300$ cm²','B) $300$ cm²','C) $330$ cm²','D) $470$ cm²','E) větší než $470$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 250" font-family="sans-serif"> <polygon points="395,60 470,60 470,88 395,88" fill="#ffffff" stroke="#000"/> <polygon points="395,60 470,60 452,42" fill="#c9c9c9" stroke="#000"/> <line x1="452" y1="42" x2="452" y2="70" stroke="#000" stroke-dasharray="3 3"/> <line x1="470" y1="60" x2="470" y2="88" stroke="#000"/> <polygon points="55,205 150,120 360,120 455,205" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <polygon points="55,205 150,120 108,205" fill="#c9c9c9" stroke="#000"/> <polygon points="455,205 360,120 402,205" fill="#c9c9c9" stroke="#000"/> <line x1="108" y1="205" x2="402" y2="205" stroke="#000"/> <line x1="150" y1="120" x2="255" y2="205" stroke="#000" stroke-dasharray="3 3"/> <line x1="360" y1="120" x2="255" y2="205" stroke="#000" stroke-dasharray="3 3"/> </svg>',
  'slepene-teleso.svg',
  'Těleso slepené ze čtyř trojbokých hranolů se dvěma tmavými a čtyřmi bílými stěnami; vpravo nahoře jeden trojboký hranol (schematicky).',
  'Slepené těleso a trojboký hranol (schematicky)',
  new List<String>{'Odvěsny pravoúhlé podstavy jsou $15$ cm a $8$ cm, neboť $15^2+8^2=17^2$. Bílé (obdélníkové) stěny slepeného tělesa mají dohromady obsah $470$ cm².'},
  'D) $470$ cm²',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
