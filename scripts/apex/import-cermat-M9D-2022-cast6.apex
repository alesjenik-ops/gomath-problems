String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, druhý náhradní termín (M9D)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2022 M9D · úloha 12',
  new List<String>{'Čtyřúhelník je rozdělen na dva tmavé rovnostranné trojúhelníky, jeden bílý čtyřúhelník a jeden bílý trojúhelník (viz obrázek). Jsou vyznačeny úhly $41^\\circ$, $36^\\circ$ a hledaný úhel $\\varphi$.','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $105^\\circ$','B) $110^\\circ$','C) $115^\\circ$','D) $120^\\circ$','E) větší než $120^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 235 102"><path d="M97 97L137 28L177 97L97 97Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M123 4L177 97L231 4L123 4Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M97 97L4 97M123 4L4 97M97 97L87 32" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M117 62C109 57 100 55 91 56M43 97C43 88 40 80 35 73M90 49C96 48 101 44 103 38C105 33 105 26 101 21" style="fill:none;stroke:#000000;stroke-width:1"/><text x="102" y="72" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">36</text><text x="110" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="28" y="96" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">41</text><text x="37" y="95" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="96" y="40" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜑</text></svg>',
  'obr.svg',
  'Čtyřúhelník rozdělený na dva tmavé rovnostranné trojúhelníky, bílý čtyřúhelník a bílý trojúhelník; vyznačené úhly 41°, 36° a hledaný úhel φ.',
  '',
  new List<String>{'Ve vrcholu na spodní přímce se stýkají tři úhly tvořící přímý úhel: úhel bílého trojúhelníku, vyznačený úhel $36^\\circ$ a úhel rovnostranného trojúhelníku $60^\\circ$. Úhel bílého trojúhelníku při tomto vrcholu je $180^\\circ-36^\\circ-60^\\circ=84^\\circ$.','V bílém trojúhelníku jsou úhly $41^\\circ$, $84^\\circ$ a třetí úhel $180^\\circ-41^\\circ-84^\\circ=55^\\circ$. Úhel $\\varphi$ je vedlejší k tomuto úhlu (leží na přímém rameni), takže $\\varphi=180^\\circ-55^\\circ=125^\\circ$.','$125^\\circ>120^\\circ$, správná odpověď je E.'},
  'E) větší než $120^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 13',
  new List<String>{'Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník, jehož dvě delší strany měří $17\\ \\mathrm{cm}$ a $15\\ \\mathrm{cm}$. Výška hranolu je $5\\ \\mathrm{cm}$. Obě podstavy hranolu jsou tmavé, ostatní stěny jsou bílé.','Ze čtyř těchto trojbokých hranolů je slepeno těleso, které má dvě shodné stěny tmavé a zbývající čtyři stěny bílé.','Jaký obsah mají dohromady všechny bílé stěny slepeného tělesa?'},
  new List<String>{'A) menší než $300\\ \\mathrm{cm}^2$','B) $300\\ \\mathrm{cm}^2$','C) $330\\ \\mathrm{cm}^2$','D) $470\\ \\mathrm{cm}^2$','E) větší než $470\\ \\mathrm{cm}^2$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Přepona pravoúhlého trojúhelníku je $17\\ \\mathrm{cm}$, jedna odvěsna $15\\ \\mathrm{cm}$, druhá $\\sqrt{17^2-15^2}=\\sqrt{64}=8\\ \\mathrm{cm}$.','Bílé (obdélníkové) stěny jednoho hranolu mají obsahy $8\\cdot5=40$, $15\\cdot5=75$ a $17\\cdot5=85\\ \\mathrm{cm}^2$, dohromady $200\\ \\mathrm{cm}^2$; u čtyř hranolů $800\\ \\mathrm{cm}^2$.','Slepené těleso má vně jen $4$ bílé stěny; slepené (vnitřní) obdélníkové stěny mají obsah $330\\ \\mathrm{cm}^2$, takže vnější bílé stěny mají obsah $800-330=470\\ \\mathrm{cm}^2$.'},
  'D) $470\\ \\mathrm{cm}^2$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','vyber','bez-kalkulacky'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 14',
  new List<String>{'Těleso je slepeno ze čtyř shodných trojbokých kolmých hranolů z úlohy 13 (podstava je pravoúhlý trojúhelník s odvěsnami $8\\ \\mathrm{cm}$ a $15\\ \\mathrm{cm}$, výška hranolu je $5\\ \\mathrm{cm}$).','Jaký je objem slepeného tělesa?'},
  new List<String>{'A) $960\\ \\mathrm{cm}^3$','B) $1\\,200\\ \\mathrm{cm}^3$','C) $1\\,280\\ \\mathrm{cm}^3$','D) $1\\,360\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Obsah podstavy jednoho hranolu je $\\frac{1}{2}\\cdot8\\cdot15=60\\ \\mathrm{cm}^2$, objem $60\\cdot5=300\\ \\mathrm{cm}^3$.','Slepením se objem nemění, celkem $4\\cdot300=1\\,200\\ \\mathrm{cm}^3$.'},
  'B) $1\\,200\\ \\mathrm{cm}^3$',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PDD22C0T04', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
